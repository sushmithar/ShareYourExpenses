class Api::V1::GroupsController < ApplicationController
    before_action :set_group, only: [:add_user, :enable_simplify_debt,
        :disable_simplify_debt, :fetch_bills_of_group]
    def create
        @group = Group.new(groups_params)
        if @group.save
            user_id = params[:user_id] || params.dig(:group, :user_id)
            GroupUser.create(user_id: user_id, group_id: @group.id) if user_id
            render json: @group, status: :created
        else
            render json: @group.errors, status: :unprocessable_entity
        end
    end
 
    def add_user
        begin
            user_id = params[:user_id] 
            if @group.users.exists?(user_id)
                render json: { error: "User already exists in this group" }, status: :unprocessable_entity
            else @group.users << User.find(user_id)
                render json: { message: "Added user successfully to this group"}, status: :ok
            end
        rescue ActiveRecord::RecordNotFound
            render json: { error: "Group or user not found" }, status: :not_found
        end
    end

    def enable_simplify_debt
        if @group.update(IsSimplifyDebtEnabled: true)
            render json: { message: "SimplifyDebt is enabled for this group" }, status: :ok
        else
            render json: { error: "Unable enable the SimplifyDebt"}, status: :unprocessable_entity
        end 
    end

    def disable_simplify_debt
        if @group.update(IsSimplifyDebtEnabled: false)
            render json: { message: "SimplifyDebt is disable for this group" }, status: :ok
        else
            render json: { error: "Unable disable the SimplifyDebt"}, status: :unprocessable_entity
        end 
    end

    def fetch_bills_of_group
        expenses = @group.expenses
        if expenses.present?
            render json: expenses, status: :ok
        else
            render json: {message: "No bills / expenses present in this group"}, status: :unprocessable_entity
        end
    end
 
 
    private
 
    def set_group
        @group = Group.find(params[:id])
    end
 
    def groups_params
        params.require(:groups).permit(:group_name, :description, :group_type, :currency, :IsSimplifyDebtEnabled)
    end
end
