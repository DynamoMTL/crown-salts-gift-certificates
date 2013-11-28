# == Schema Information
#
# Table name: transfers
#
#  id              :integer          not null, primary key
#  bank_account_id :integer
#  stripe_token    :string(255)
#  description     :text
#  name            :string(255)
#  status          :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Transfer < ActiveRecord::Base
  belongs_to :bank_account

  def initiate_transfer(amount)
    Stripe::Transfer.create(
        :amount => (amount.to_f * 100).to_i,
        :currency => "usd",
        :recipient => self.bank_account.user.stripe_recipient_token,
        :description => self.description
    )
  end

  def cancel
    transfer = Stripe::Transfer.retrieve(self.stripe_token)
    transfer.cancel
  end
end
