class User < ApplicationRecord
  has_many :posts
  has_many :likes

  mount_uploader :avatar, UserImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
