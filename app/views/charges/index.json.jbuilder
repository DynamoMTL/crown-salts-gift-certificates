json.array!(@charges) do |charge|
  json.extract! charge, :card_id, :stripe_token, :description, :refunded
  json.url charge_url(charge, format: :json)
end
