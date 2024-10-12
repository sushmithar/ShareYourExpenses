class ExpenseTransaction < ApplicationRecord
  belongs_to :expense
  belongs_to :payer, class_name: 'User'
  belongs_to :payee, class_name: 'User'

  validates :amount_paid, presence: true, numericality: {greater_than: 0}
end
