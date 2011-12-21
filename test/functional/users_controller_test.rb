require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get show" do
    get :show, id: @user.id
    assert_response :success
  end
end
