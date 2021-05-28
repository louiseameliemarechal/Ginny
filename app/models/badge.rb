class Badge < ApplicationRecord
  has_many :badge_recos
  validates :name, presence: true, uniqueness: true

  def self.all_names
    pluck(:name).uniq
  end

end
