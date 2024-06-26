require "test_helper"

class SessionControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should get create" do
    post login_path
    assert_response :success
  end

  test "should get destroy" do
    delete logout_path
    assert_response :redirect
  end
end
