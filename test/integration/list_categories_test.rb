require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create({name: 'sports'})
    # #{poitable_type.downcase}_counter": count
  end

  test "should show category listing" do
    get '/categories'
    # category.name text will show up
    # we are going to look for links that contain these categories
    #
    assert_select "a[href=?]", category_path(@category), text: @category.name
  end
end
