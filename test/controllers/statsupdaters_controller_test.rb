require 'test_helper'

class StatsupdatersControllerTest < ActionController::TestCase
  setup do
    @statsupdater = statsupdaters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statsupdaters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create statsupdater" do
    assert_difference('Statsupdater.count') do
      post :create, statsupdater: { interval: @statsupdater.interval, name: @statsupdater.name }
    end

    assert_redirected_to statsupdater_path(assigns(:statsupdater))
  end

  test "should show statsupdater" do
    get :show, id: @statsupdater
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @statsupdater
    assert_response :success
  end

  test "should update statsupdater" do
    patch :update, id: @statsupdater, statsupdater: { interval: @statsupdater.interval, name: @statsupdater.name }
    assert_redirected_to statsupdater_path(assigns(:statsupdater))
  end

  test "should destroy statsupdater" do
    assert_difference('Statsupdater.count', -1) do
      delete :destroy, id: @statsupdater
    end

    assert_redirected_to statsupdaters_path
  end
end
