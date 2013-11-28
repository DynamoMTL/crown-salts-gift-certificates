json.array!(@users) do |user|
  json.extract! user, :name, :stripe_token, :stripe_recipient_token
  json.url user_url(user, format: :json)
end
