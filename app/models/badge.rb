class Badge < ApplicationRecord
  has_many :badge_recos
  validates :picto, presence: true, uniqueness: true


end
