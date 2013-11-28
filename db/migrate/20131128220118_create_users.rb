class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :stripe_token
      t.string :stripe_recipient_token

      t.timestamps
    end
  end
end
