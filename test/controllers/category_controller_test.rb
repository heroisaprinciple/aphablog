require "test_helper"

class CategoryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should show categories" do
    get category_url(@category)
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count', 1) do # we want to see the change in categories number, so we'll
      # increment by 1
      post categories_url, params: { category: { name: 'Travel'} } # params is a hash, don't you FORGET ABOUT IT
    end

    assert_redirected_to category_url(Category.last) # whatever the last category is, we'll redirect to it
  end

  # test "should get edit" do
  #   get edit_category_url(@categories)
  #   assert_response :success
  # end

  #test "should update categories" do
  #  patch category_url(@categories), params: { categories: {}}
  #  assert_redirected_to category_url(@categories)
  #end

end
