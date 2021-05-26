class Doctor < ApplicationRecord
  has_many :recommendations

  has_many :tags, -> { distinct }, through: :recommendations
  has_many :badges, -> { distinct }, through: :recommendations
  validates :first_name, :last_name, :address, :profession, :gender, presence: true

  # geocoded_by :address
  # after_validation :geocode, if: :will_save_change_to_address?

  def self.professions
    pluck(:profession).uniq
  end

  def self.genders
    pluck(:gender).uniq
  end

  def self.conventions
    pluck(:convention).uniq
  end
end
