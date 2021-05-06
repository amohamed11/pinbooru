require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest

  setup do
    @multipleImagesPost = posts(:one)
    @singleImagePost = posts(:two)

    @multipleImagesPost.images.attach(fixture_file_upload("files/one.jpg", "image/jpg"))
    @singleImagePost.images.attach(fixture_file_upload("files/two.jpg", "image/jpg"))

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
      post posts_url, params: { post: { caption: "a post with one image", images: [fixture_file_upload("files/one.jpg", "image/jpg")] } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should create post with multiple images" do
    assert_difference('Post.count') do
      post posts_url, params: { post: { caption: "another post with two images", images: [fixture_file_upload("files/one.jpg", "image/jpg"), fixture_file_upload("files/two.jpg", "image/jpg")] } }
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

  test "should update post with a different image" do
    assert_equal @singleImagePost.images[0].filename(), "two.jpg"

    @singleImagePost.images[0].purge()

    patch post_url(@singleImagePost), params: { post: { caption: "updated caption", images: [fixture_file_upload("files/one.jpg", "image/jpg")] } }

    @singleImagePost.reload
    @singleImagePost.images.reload

    assert_redirected_to post_url(@singleImagePost)
    assert_equal @singleImagePost.caption, "updated caption"
    assert_equal @singleImagePost.images.count, 1
    assert_equal @singleImagePost.images[0].filename(), "one.jpg"
  end

  test "should update post by adding an image" do
    assert_equal @multipleImagesPost.images.count, 1

    patch post_url(@multipleImagesPost), params: { post: { caption: "updated caption two", images:  [fixture_file_upload("files/two.jpg", "image/jpg")] } }

    @multipleImagesPost.reload
    @multipleImagesPost.images.reload

    assert_redirected_to post_url(@multipleImagesPost)

    assert_equal @multipleImagesPost.caption, "updated caption two"
    assert_equal @multipleImagesPost.images.count, 2
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@singleImagePost)
    end

    assert_redirected_to posts_url
  end
end
