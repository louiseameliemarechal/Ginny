class Recommendation < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
  has_many :badge_recos
  has_many :badges, through: :badge_recos
  has_many :tag_recos
  has_many :tags, through: :tag_recos
end
