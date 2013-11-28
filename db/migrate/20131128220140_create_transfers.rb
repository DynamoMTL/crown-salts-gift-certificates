class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.references :bank_account, index: true
      t.string :stripe_token
      t.text :description
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end
