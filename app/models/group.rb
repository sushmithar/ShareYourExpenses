class Group < ApplicationRecord
    
    enum group_type: {
        trip: "Trip",
        home: "Home",
        project: "Project",
        event: "Event",
        others: "Others"
      }

    enum currency: {
        rupee: "Rupee",
        yen: "Yen",
        euro: "Euro",
        dollar: "Dollar"
    }

    has_many :group_users
    has_many :users, through: :group_users
    has_many :expenses
    
    validates :group_name, presence: true, uniqueness: true
    validates :currency, presence: true
end
