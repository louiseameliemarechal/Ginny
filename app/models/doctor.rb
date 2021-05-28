class Doctor < ApplicationRecord
  has_many :recommendations
  has_many :favorites
  has_many :tags, through: :recommendations
  has_many :badges, through: :recommendations
  validates :first_name, :last_name, :profession, :gender, presence: true

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

  def badges
    recommendations.map do |reco|
      reco.badges
    end.flatten
  end

  def labels
    recommendations.map do |reco|
      reco.labels
    end.flatten
  end

end
