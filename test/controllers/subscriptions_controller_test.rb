require "test_helper"

class SubscriptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subscription = subscriptions(:one)
  end

  test "should get index" do
    get subscriptions_url, as: :json
    assert_response :success
  end

  test "should create subscription" do
    assert_difference("Subscription.count") do
      post subscriptions_url, params: { subscription: { end_date: @subscription.end_date, name: @subscription.name, plate_number: @subscription.plate_number, start_date: @subscription.start_date, type_of_pass: @subscription.type_of_pass } }, as: :json
    end

    assert_response :created
  end

  test "should show subscription" do
    get subscription_url(@subscription), as: :json
    assert_response :success
  end

  test "should update subscription" do
    patch subscription_url(@subscription), params: { subscription: { end_date: @subscription.end_date, name: @subscription.name, plate_number: @subscription.plate_number, start_date: @subscription.start_date, type_of_pass: @subscription.type_of_pass } }, as: :json
    assert_response :success
  end

  test "should destroy subscription" do
    assert_difference("Subscription.count", -1) do
      delete subscription_url(@subscription), as: :json
    end

    assert_response :no_content
  end
end
