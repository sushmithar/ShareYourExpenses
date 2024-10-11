class User < ApplicationRecord
    has_many :group_users
    has_many :groups, through: :group_users
    
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Please provide a valid email id" }   
end
