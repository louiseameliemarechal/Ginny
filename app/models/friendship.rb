class Friendship < ApplicationRecord
  belongs_to :user
  # friend = autre user :
  belongs_to :friend, class_name: 'User'
end
