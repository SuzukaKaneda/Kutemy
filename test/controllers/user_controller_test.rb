require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end
end
