# == Schema Information
#
# Table name: charges
#
#  id           :integer          not null, primary key
#  card_id      :integer
#  stripe_token :string(255)
#  description  :text
#  refunded     :boolean
#  created_at   :datetime
#  updated_at   :datetime
#

class Charge < ActiveRecord::Base
  belongs_to :card

  def refund
    ch = Stripe::Charge.retrieve(self.stripe_token)
    ch.refund
  end
end
