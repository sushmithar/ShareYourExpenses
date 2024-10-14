class Api::V1::ExpensesController < ApplicationController
    def create
        @expense = Expense.new(expenses_params)
        if @expense.save
            transactions_data = transaction_params[:user_ids] || transaction_params[:transactions]
            service = ExpenseTransactionService.new(@expense, transactions_data)
            if service.create_transactions
                render json: @expense, status: :created
              else
                render json: { errors: service.errors }, status: :unprocessable_entity
              end
        else
            render json: { errors: @expense.errors.full_messages },
                status: :unprocessable_entity
        end
    end

    private

    def expenses_params
        params.require(:expense).permit(:name, :total_amount, :group_id,
            :category, :split_equally, :user_id)
    end

    def transaction_params
        params.require(:expense_transactions).permit(user_ids: [],
            transactions: [:user_id, :amount_paid])
    end
end
