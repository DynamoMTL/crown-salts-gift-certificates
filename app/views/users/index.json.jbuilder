json.array!(@users) do |user|
  json.extract! user, :name, :stripe_token
  json.url user_url(user, format: :json)
end
