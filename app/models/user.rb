class User < ApplicationRecord
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Please provide a valid email id" }   
end
