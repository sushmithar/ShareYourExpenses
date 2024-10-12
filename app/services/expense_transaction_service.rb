class ExpenseTransactionService
    def initialize(expense, expense_transactions)
      @expense = expense
      @expense_transactions = expense_transactions
    end
  
    def create_transactions
        if @expense.split_equally
            create_split_equal_transactions
        else
            create_expense_transactions
        end
    end

    def create_split_equal_transactions
        user_ids = @expense_transactions
        split_amount = @expense.total_amount / user_ids.size.to_f
        user_ids.each do |user_id|
            user = User.find(user_id)
            # Assuming the user who add the expense paid the amount
            ExpenseTransaction.create!(
                expense: @expense,
                payer: @expense.user,  
                payee: user,
                amount_paid: split_amount
            )
        end
    end

    def create_expense_transactions
        @expense_transactions.each do |transaction|
            user = User.find(transaction[:user_id])
            # Assuming the user who add the expense paid the amount
            ExpenseTransaction.create!(
                expense: @expense,
                payer: @expense.user,
                payee: user,
                amount_paid: transaction[:amount_paid]
            )
        end
    end
  end
  