class Doctor < ApplicationRecord
  validates :first_name, :last_name, :address, :profession, :gender, presence: true
end
