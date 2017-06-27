json.array!(@administrators) do |administrator|
  json.extract! administrator, :id, :first_name, :last_name, :email, :hashed_password
  json.url administrator_url(administrator, format: :json)
end
