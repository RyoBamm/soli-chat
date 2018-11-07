class Like < ApplicationRecord
  belongs_to :post, optional: true, counter_cache: :likes_count
  belongs_to :user, optional: true
end
