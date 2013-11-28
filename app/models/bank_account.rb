# == Schema Information
#
# Table name: bank_accounts
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  stripe_token :string(255)
#  description  :text
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class BankAccount < ActiveRecord::Base
  belongs_to :user
end
