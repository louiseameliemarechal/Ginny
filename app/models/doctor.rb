class Doctor < ApplicationRecord
  has_many :recommendations
  has_many :favorites
  has_many :tags, -> { distinct }, through: :recommendations
  has_many :badges, -> { distinct }, through: :recommendations
  validates :first_name, :last_name, :profession, :gender, presence: true

  reverse_geocoded_by :latitude, :longitude
  # after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_name_and_specialty, 
    against: [ 
      [:last_name, "A"],
      :first_name,
      :specialty
    ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }

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
