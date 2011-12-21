require 'test_helper'

class CodesControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    @code = codes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:codes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create code" do
    sign_in @user

    assert_difference('Code.count') do
      post :create, code: @code.attributes
    end

    assert_redirected_to code_path(assigns(:code))
  end

  test "should show code" do
    get :show, id: @code.to_param
    assert_response :success
  end

  test "should update code" do
    sign_in @code.user

    put :update, id: @code.to_param, code: @code.attributes
    assert_redirected_to code_path(assigns(:code))
  end

  test "should destroy code" do
    assert_difference('Code.count', -1) do
      delete :destroy, id: @code.to_param
    end

    assert_redirected_to codes_path
  end
end
