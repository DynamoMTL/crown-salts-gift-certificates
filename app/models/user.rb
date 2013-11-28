# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  stripe_token           :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  stripe_recipient_token :string(255)
#

class User < ActiveRecord::Base
  has_many :cards, dependent: :destroy
  has_many :bank_accounts, dependent: :destroy

  def add_card(stripe_token)
    if self.stripe_token
      #this user already has a stripe customer account, so add this card
      customer = Stripe::Customer.retrieve(self.stripe_token)
      card_response = customer.cards.create(:card => stripe_token)
      card_token = card_response[:id]
    else
      #create a "Customer" object with stripe so we can utilize recurring charges

      response = Stripe::Customer.create(
          :description => "#{self.name} for test@example.com",
          :card => "#{stripe_token}" # obtained with Stripe.js
      )
      self.update_attribute(:stripe_token, response[:id])
      card_token = response[:default_card]
    end
    card_token
  end

end
