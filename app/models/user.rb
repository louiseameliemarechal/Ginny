class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :recommendations
  has_many :favorites
  has_many :doctors, through: :favorites
  # retourne les relations d'amitiées
  has_many :friendships, dependent: :destroy
  # retourne les users que je follow (les amies, pas juste la relation)
  has_many :friends, through: :friendships, class_name: 'User'
  has_one_attached :photo
  validates :username, presence: true, uniqueness: true
  # validates :phone_number, presence: true, uniqueness: true, format: { with: /0[6-7]\d{8}/, message: "format invalide" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def favorite_doctor?(doctor)
    favorites.pluck(:doctor_id).include?(doctor.id)
  end

  def favorite(doctor)
    favorites.find_by(doctor: doctor)
  end

  def recommended_doctor?(doctor)
    recommendations.pluck(:doctor_id).include?(doctor.id)
  end

  def follow(profile)
    friendships.find_by(friend_id: profile.id)
  end
end
