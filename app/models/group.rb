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
        dollor: "Dollor",
        euro: "Euro"
    }
    
    validates :group_name, presence: true, uniqueness: true
    validates :currency, presence: true
end
