require 'test_helper'

class RightsControllerTest < ActionController::TestCase
  setup do
    @right = rights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create right" do
    assert_difference('Right.count') do
      post :create, right: { title: @right.title }
    end

    assert_redirected_to right_path(assigns(:right))
  end

  test "should show right" do
    get :show, id: @right
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @right
    assert_response :success
  end

  test "should update right" do
    put :update, id: @right, right: { title: @right.title }
    assert_redirected_to right_path(assigns(:right))
  end

  test "should destroy right" do
    assert_difference('Right.count', -1) do
      delete :destroy, id: @right
    end

    assert_redirected_to rights_path
  end
end
