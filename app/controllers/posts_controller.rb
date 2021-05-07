class PostsController < ApplicationController
  include Pagy::Backend

  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /posts or /posts.json
  def index
    @pagy, @posts = pagy(Post.with_attached_images.all.order("created_at DESC"))
    @post_authors = @posts.map { |p| p.user_id = (User.find_by id: p.user_id).name }
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post_author = User.find_by id: @post.user_id
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        VariantsGeneratorJob.perform_later @post.id
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params) and @post.user_id == current_user.id
        VariantsGeneratorJob.perform_later @post.id
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.user_id == current_user.id
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  def delete_image
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge_later
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:caption, :user_id, images: [])
    end
end
