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
end
