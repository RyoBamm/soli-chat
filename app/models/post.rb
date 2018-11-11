class Post < ApplicationRecord

  MAX_POST_CATEGORIES_LENGTH = 3

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  # accepts_nested_attributes_for :post_categories, allow_destroy: true

  mount_uploader :video, VideoUploader

  enum post_type: %i(video youtube)

  validates :title, :post_type, :user_id, presence: true
  validates :post_categories, length: {maximum: MAX_POST_CATEGORIES_LENGTH}
  validate :posts_deplication_checker

  def posts_deplication_checker
    if video.present? && youtube.present?
      errors[:base] << "コンテンツが重複しています"
    elsif youtube.blank? && video.blank?
      errors[:base] << "コンテンツがありません"
    end
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
