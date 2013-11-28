json.array!(@cards) do |card|
  json.extract! card, :user_id, :stripe_token, :description
  json.url card_url(card, format: :json)
end
