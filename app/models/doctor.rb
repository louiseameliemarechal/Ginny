class Doctor < ApplicationRecord
  has_many :recommendations
  validates :first_name, :last_name, :address, :profession, :gender, presence: true
end
