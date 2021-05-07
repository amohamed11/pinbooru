class Post < ApplicationRecord
  validates :caption, presence: true
  belongs_to :user
  has_many_attached :images

  validates :images, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  before_destroy :purge_images, prepend: true

  def thumbnail(image)
    variant = image.variant(resize_to_fill: [620, 680], quality: 75)
    return variant
  end

  def tiny_preview(image)
    variant = image.variant(resize_to_fill: [200, 200], quality: 50)
    return variant
  end

  private

  def purge_images
    images.purge_later
  end

 end
