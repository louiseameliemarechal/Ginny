class Tag < ApplicationRecord
  has_many :tag_recos
  validates :name, presence: true, uniqueness: true

  def self.all_names
    pluck(:name).uniq
  end

end
