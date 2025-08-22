json.extract! investor, :id, :first_name, :last_name, :dob, :phone, :street_address, :state, :zip, :created_at, :updated_at
json.url investor_url(investor, format: :json)
