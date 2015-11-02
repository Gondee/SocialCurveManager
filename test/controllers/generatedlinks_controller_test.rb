require 'test_helper'

class GeneratedlinksControllerTest < ActionController::TestCase
  setup do
    @generatedlink = generatedlinks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:generatedlinks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create generatedlink" do
    assert_difference('Generatedlink.count') do
      post :create, generatedlink: { date: @generatedlink.date, paidout: @generatedlink.paidout, url: @generatedlink.url }
    end

    assert_redirected_to generatedlink_path(assigns(:generatedlink))
  end

  test "should show generatedlink" do
    get :show, id: @generatedlink
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @generatedlink
    assert_response :success
  end

  test "should update generatedlink" do
    patch :update, id: @generatedlink, generatedlink: { date: @generatedlink.date, paidout: @generatedlink.paidout, url: @generatedlink.url }
    assert_redirected_to generatedlink_path(assigns(:generatedlink))
  end

  test "should destroy generatedlink" do
    assert_difference('Generatedlink.count', -1) do
      delete :destroy, id: @generatedlink
    end

    assert_redirected_to generatedlinks_path
  end
end
