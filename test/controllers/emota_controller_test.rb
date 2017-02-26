require 'test_helper'

class EmotaControllerTest < ActionController::TestCase
  setup do
    @emotum = emota(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:emota)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create emotum" do
    assert_difference('Emotum.count') do
      post :create, emotum: {  }
    end

    assert_redirected_to emotum_path(assigns(:emotum))
  end

  test "should show emotum" do
    get :show, id: @emotum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @emotum
    assert_response :success
  end

  test "should update emotum" do
    patch :update, id: @emotum, emotum: {  }
    assert_redirected_to emotum_path(assigns(:emotum))
  end

  test "should destroy emotum" do
    assert_difference('Emotum.count', -1) do
      delete :destroy, id: @emotum
    end

    assert_redirected_to emota_path
  end
end
