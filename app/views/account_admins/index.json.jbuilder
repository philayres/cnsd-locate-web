json.array!(@account_admins) do |account_admin|
  json.extract! account_admin, :id, :first_name, :last_name, :email, :hashed_password
  json.url account_admin_url(account_admin, format: :json)
end
