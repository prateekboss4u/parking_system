json.extract! billing, :id, :customer_name, :amount, :duration, :plate_number, :created_at, :updated_at
json.url billing_url(billing, format: :json)
