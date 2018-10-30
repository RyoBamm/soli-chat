class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :video, VideoUploader

  enum type: %i(video youtube)

  validates :title, :video, :presence => true
end
