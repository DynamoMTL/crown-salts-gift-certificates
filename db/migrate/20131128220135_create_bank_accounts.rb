class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|
      t.references :user, index: true
      t.string :stripe_token
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
