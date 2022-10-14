require "test_helper"

class CategoryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
    @admin_user = User.create(username: 'whiteblinders', email: 'valcat552@gmail.com', password: '12345678', admin: true)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    login_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test "should show categories" do
    get category_url(@category)
    assert_response :success
  end

  test "should create category if admin" do
    login_as(@admin_user)
    assert_difference('Category.count', 1) do # we want to see the change in categories number, so we'll
      #increment by 1
     post categories_url, params: { category: { name: 'Entertainment'} } # params is a hash, don't you FORGET ABOUT IT
    end
    assert_redirected_to category_url(Category.last) # whatever the last category is, we'll redirect to it
  end

    #
  test "should not create category in not admin" do
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: 'Entertainment'} }
    end
    assert_redirected_to categories_url

  # test "should get edit" do
  #   get edit_category_url(@categories)
  #   assert_response :success
  # end

  #test "should update categories" do
  #  patch category_url(@categories), params: { categories: {}}
  #  assert_redirected_to category_url(@categories)
  #end
  end
end
