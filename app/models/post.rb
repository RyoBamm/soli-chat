class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :video, VideoUploader

  enum post_type: %i(video youtube)

  validates :title,
            :post_type,
            :user_id,
            presence: true, if: :require_validation?

  def require_validation?
    if :video.present? && :youtube.blank?
      return true
    elsif :youtube.present? && :video.blank?
      return true
    else
      return false
    end
  end

end
