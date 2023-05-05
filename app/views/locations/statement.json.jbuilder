json.location_name @location.location_name
json.statement do
  json.array! @statement[:transactions], partial: "locations/subscription", as: :subscription, location: @location
end

