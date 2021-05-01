require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @multipleImagesPost = posts(:one)
    @singleImagePost = posts(:two)

    @multipleImagesPost.images.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'one.jpg')), filename: "post1cat1.jpg", content_type: "image/jpg")
    @multipleImagesPost.images.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'two.jpg')), filename: "post1cat2.jpg", content_type: "image/jpg")
    @singleImagePost.images.attach(io: File.open(Rails.root.join('test', 'fixtures', 'files', 'one.jpg')), filename: "post2cat1.jpg", content_type: "image/jpg")

    sign_in users(:one)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "creating a Post" do
    visit posts_url
    click_on "New Post"

    fill_in "Caption", with: @singleImagePost.caption
    fill_in "Images", with: @singleImagePost.images
    click_on "Create Post"

    assert_text "Post was successfully created"
    click_on "Back"
  end

  test "updating a Post" do
    visit posts_url
    click_on "Edit", match: :first

    fill_in "Caption", with: @multipleImagesPost.caption
    fill_in "Images", with: @multipleImagesPost.images
    click_on "Update Post"

    assert_text "Post was successfully updated"
    click_on "Back"
  end

  test "destroying a Post" do
    visit posts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post was successfully destroyed"
  end
end
