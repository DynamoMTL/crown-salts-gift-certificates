#SET YOUR STRIPE API KEYs BELOW
StripeTest::Application.config.stripe_publishable_key = ''
StripeTest::Application.config.stripe_secret_key = ''

unless StripeTest::Application.config.stripe_publishable_key.present? &&
    StripeTest::Application.config.stripe_secret_key.present?
  raise Exception.new("Set Stripe API keys above!")
end

Stripe.api_key = StripeTest::Application.config.stripe_secret_key

#Monkey patching String::Transfer class to add cancel.  missing from API
#https://stripe.com/docs/api/ruby#cancel_transfer

class Stripe::Transfer
  def cancel(params={})
    response, api_key = Stripe.request(:post, cancel_url, @api_key, params)
    refresh_from(response, api_key)
    self
  end

  private

  def cancel_url
    url + '/cancel'
  end
end