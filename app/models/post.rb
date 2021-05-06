class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :images, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
end
