class GroupUser < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :user_id, uniqueness: { scope: :group_id, message: "has already been added to this group" }
end
