class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :recommendations
  has_many :favorites
  has_many :friendships
  validates :username, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\d[0-9]\)*\z/, message: "format invalide" }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
