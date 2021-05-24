class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :recommendations
  has_many :favorites
  has_many :friendships
  validates :username, :phone_number, presence: true, uniqueness: true 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
