class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :split_equally, :total_amount
end
