class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images do |attachable|
    attachable.variant :preview, resize: "480x480"
    attachable.variant :thumb, resize: "120x120"
  end
end
