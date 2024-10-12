class Expense < ApplicationRecord
  enum group_type: {
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

  validates :name, presence: true, uniqueness: true
  validates :total_amount, presence: true
  validates :split_equaly, presence: true
end
