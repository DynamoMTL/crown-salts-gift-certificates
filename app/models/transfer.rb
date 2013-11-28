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
end
