class User < ApplicationRecord
    has_many :group_users
    has_many :groups, through: :group_users
    has_many :expenses
    has_many :paid_transactions, class_name: 'ExpenseTransaction', foreign_key: 'payer_id'
    has_many :received_transactions, class_name: 'ExpenseTransaction', foreign_key: 'payee_id'

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Please provide a valid email id" }   
end
