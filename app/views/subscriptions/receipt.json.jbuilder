json.receipt do
  json.array! @receipt[:transactions], partial: "subscriptions/billing", as: :billing, subscription: @subscription
end