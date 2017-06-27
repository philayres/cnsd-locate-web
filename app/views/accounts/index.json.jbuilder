json.array!(@accounts) do |account|
  json.extract! account, :id, :owner_name
  json.url account_url(account, format: :json)
end
