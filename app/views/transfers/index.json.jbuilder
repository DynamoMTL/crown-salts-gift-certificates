json.array!(@transfers) do |transfer|
  json.extract! transfer, :bank_account_id, :stripe_token, :description, :name, :status
  json.url transfer_url(transfer, format: :json)
end
