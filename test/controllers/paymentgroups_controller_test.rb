require 'test_helper'

class PaymentgroupsControllerTest < ActionController::TestCase
  setup do
    @paymentgroup = paymentgroups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paymentgroups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paymentgroup" do
    assert_difference('Paymentgroup.count') do
      post :create, paymentgroup: { generatedlink_id: @paymentgroup.generatedlink_id, note: @paymentgroup.note, transaction_id: @paymentgroup.transaction_id }
    end

    assert_redirected_to paymentgroup_path(assigns(:paymentgroup))
  end

  test "should show paymentgroup" do
    get :show, id: @paymentgroup
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @paymentgroup
    assert_response :success
  end

  test "should update paymentgroup" do
    patch :update, id: @paymentgroup, paymentgroup: { generatedlink_id: @paymentgroup.generatedlink_id, note: @paymentgroup.note, transaction_id: @paymentgroup.transaction_id }
    assert_redirected_to paymentgroup_path(assigns(:paymentgroup))
  end

  test "should destroy paymentgroup" do
    assert_difference('Paymentgroup.count', -1) do
      delete :destroy, id: @paymentgroup
    end

    assert_redirected_to paymentgroups_path
  end
end
