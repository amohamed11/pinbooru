module Api
  module V1
    class PostsController < ApiController
      include Pagy::Backend

      # Paginated using pagy, with json formatted using jbuilder
      def index
        @pagy, @posts = pagy(Post.with_attached_images.all.order("created_at DESC"))
      end

      def show
        @post = Post.find(params[:id])
      end

      def create
        @post = Post.create!(post_params)
      end

      def update
        @post.update(post_params)
        head :no_content
      end

      def destroy
        @post.destroy
        head :no_content
      end

      private

      def post_params
        params.require(:post).permit(:caption, :user_id, images: [])
      end

      def set_post
        @post = Post.find(params[:id])
      end
    end
  end
end
