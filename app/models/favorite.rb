class Favorite < ApplicationRecord
  belongs_to :doctor
  belongs_to :user
  # favoris que pour un medecin et un user
  validates :user, uniqueness: { scope: :doctor }
end
