class Like < ApplicationRecord
  has_many :posts, counter_cache: :likes_count
  has_many :users
end
