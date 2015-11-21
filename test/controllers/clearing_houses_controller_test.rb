require 'test_helper'

class ClearingHousesControllerTest < ActionController::TestCase
  setup do
    @clearing_house = clearing_houses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:clearing_houses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create clearing_house" do
    assert_difference('ClearingHouse.count') do
      post :create, clearing_house: { note: @clearing_house.note, publisher_id: @clearing_house.publisher_id, user_id: @clearing_house.user_id }
    end

    assert_redirected_to clearing_house_path(assigns(:clearing_house))
  end

  test "should show clearing_house" do
    get :show, id: @clearing_house
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @clearing_house
    assert_response :success
  end

  test "should update clearing_house" do
    patch :update, id: @clearing_house, clearing_house: { note: @clearing_house.note, publisher_id: @clearing_house.publisher_id, user_id: @clearing_house.user_id }
    assert_redirected_to clearing_house_path(assigns(:clearing_house))
  end

  test "should destroy clearing_house" do
    assert_difference('ClearingHouse.count', -1) do
      delete :destroy, id: @clearing_house
    end

    assert_redirected_to clearing_houses_path
  end
end
