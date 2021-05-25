class Recommendation < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
  has_many :badge_recos
  has_many :tag_recos

end
