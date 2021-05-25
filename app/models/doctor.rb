class Doctor < ApplicationRecord
  has_many :recommendations
  validates :first_name, :last_name, :address, :profession, :gender, presence: true
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
