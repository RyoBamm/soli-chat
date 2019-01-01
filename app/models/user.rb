class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :active_relationships, class_name: "UsersRelationship", foreign_key: "follower_id", dependent: :destroy
  has_many :active_relationships, class_name: "UsersRelationship", foreign_key: "followee_id", dependent: :destroy
  belongs_to :prefecture, optional: true

  accepts_nested_attributes_for :prefecture

  mount_uploader :avatar, UserImageUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
