require "test_helper"

class BillingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @billing = billings(:one)
  end

  test "should get index" do
    get billings_url, as: :json
    assert_response :success
  end

  test "should create billing" do
    assert_difference("Billing.count") do
      post billings_url, params: { billing: { amount: @billing.amount, customer_name: @billing.customer_name, duration: @billing.duration, plate_number: @billing.plate_number } }, as: :json
    end

    assert_response :created
  end

  test "should show billing" do
    get billing_url(@billing), as: :json
    assert_response :success
  end

  test "should update billing" do
    patch billing_url(@billing), params: { billing: { amount: @billing.amount, customer_name: @billing.customer_name, duration: @billing.duration, plate_number: @billing.plate_number } }, as: :json
    assert_response :success
  end

  test "should destroy billing" do
    assert_difference("Billing.count", -1) do
      delete billing_url(@billing), as: :json
    end

    assert_response :no_content
  end
end
