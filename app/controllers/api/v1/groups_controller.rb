class Api::V1::GroupsController < ApplicationController
    def create
        @group = Group.new(groups_params)
        if @group.save
            render json: @group, status: :created
        else
            render json: @group.errors, status: :unprocessable_entity
        end
    end

    private

    def set_group
        @group = Group.find(params[:group_id])
    end

    def groups_params
        params.require(:groups).permit(:group_name, :description, :type, :currency, :IsSimplifyDebtEnabled)
    end
end
