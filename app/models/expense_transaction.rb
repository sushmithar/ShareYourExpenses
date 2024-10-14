class ExpenseTransaction < ApplicationRecord
  belongs_to :expense
  belongs_to :payer, class_name: 'User'
  belongs_to :payee, class_name: 'User'

  validates :amount_paid, presence: true, numericality: {greater_than: 0}
  validate :total_amount_paid_correct

  private

  def total_amount_paid_correct
    # Check the total amount paid against the expense total
    if expense.present?
      total_paid = expense.expense_transactions.sum(:amount_paid) + amount_paid
      if total_paid > expense.total_amount
        errors.add(:base, "Total amount paid cannot exceed the total amount of the expense.")
      end
    end
  end
end
