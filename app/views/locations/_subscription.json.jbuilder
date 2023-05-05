json.extract! subscription, :id, :name, :type_of_pass, :plate_number, :start_date, :end_date, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
