class Friendship < ApplicationRecord
  belongs_to :user
  alias_attribute :friend, :user
end
