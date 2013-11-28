json.array!(@bank_accounts) do |bank_account|
  json.extract! bank_account, :user_id, :stripe_token, :description, :name
  json.url bank_account_url(bank_account, format: :json)
end
