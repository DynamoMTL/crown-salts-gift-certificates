# == Schema Information
#
# Table name: cards
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  stripe_token :string(255)
#  description  :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Card < ActiveRecord::Base
  belongs_to :user
  has_many :charges, dependent: :destroy

  def charge(amount, description)
    Stripe::Charge.create(
        :amount => (amount.to_f * 100).to_i,
        :currency => "usd",
        :customer => self.user.stripe_token,
        :card => self.stripe_token,
        :description => description
    )

  end

end
