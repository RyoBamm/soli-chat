class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments
  belongs_to :prefecture, optional: true

  accepts_nested_attributes_for :prefecture

  mount_uploader :avatar, UserImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
