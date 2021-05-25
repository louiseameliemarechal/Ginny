class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :recommendations
  has_many :favorites
  has_many :friendships
  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /0[6-7]\d{8}/, message: "format invalide" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
