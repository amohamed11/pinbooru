# Source: https://tech.kartenmacherei.de/scaling-activestorage-21e962f708d7

class VariantsGeneratorJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    return unless post.images.attached?

    post.images.each do |image|
      variant = post.thumbnail(image)
      # # This is what triggers the actual transform/cache process
      was_processed = variant.processed

      Rails.logger.info "Processed thumbnail variant for #{image.id}" if was_processed
    end
  end
end
