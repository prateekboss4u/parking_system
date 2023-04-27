json.extract! user, :id, :username, :type_of_user, :location, :city, :created_at, :updated_at
json.url user_url(user, format: :json)
