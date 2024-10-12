class Expense < ApplicationRecord
  enum category: {
    entertainment: "Entertainment",
    food_and_drink: "Food & Drink,",
    home: "Home",
    lifeStyle: "LifeStyle",
    transport: "Transport",
    utilities: "Utilities",
    general: "General"
  }

  belongs_to :group
  belongs_to :user
  has_many :expense_transactions

  accepts_nested_attributes_for :expense_transactions, allow_destroy: true

  validates :name, presence: true, uniqueness: true
  validates :total_amount, presence: true
  validates :split_equally, inclusion: { in: [true, false], message: "must be true or false" }
end
