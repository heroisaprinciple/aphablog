require "test_helper"

class CategoryTest < ActiveSupport::TestCase

  def setup # will run before each test
    @category = Category.new(name: 'Sports')
  end

  test "categories should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = ' '
    assert_not @category.valid?, 'should be present'
  end

  test "should be unique" do
    @category.save!
    @category_2 = Category.new(name: 'Sports')
    assert_not @category_2.valid?, 'should be unique'
  end

  test "name should not be too long" do
    @category.name = 'a' * 26
    assert_not @category.valid?, 'should be max 25 chars'
  end

  test "name should not be short" do
    @category.name = 'aa'
    assert_not @category.valid?, 'should be min 3 chars'
  end
end
