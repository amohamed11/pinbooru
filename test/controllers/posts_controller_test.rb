require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @multipleImagesPost = posts(:one)
    @singleImagePost = posts(:two)

    @multipleImagesPost.images.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'one.jpg')), filename: "post1cat1.jpg", content_type: "image/jpg")
    @multipleImagesPost.images.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'two.jpg')), filename: "post1cat2.jpg", content_type: "image/jpg")
    @singleImagePost.images.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'one.jpg')), filename: "post2cat1.jpg", content_type: "image/jpg")

    sign_in users(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { caption: @singleImagePost.caption, images: @singleImagePost.images } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    get post_url(@singleImagePost)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@singleImagePost)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@singleImagePost), params: { post: { caption: @multipleImagesPost.caption, images: @multipleImagesPost.images } }

    assert_redirected_to post_url(@singleImagePost)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@singleImagePost)
    end

    assert_redirected_to posts_url
  end
end
