class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :card, index: true
      t.string :stripe_token
      t.text :description
      t.boolean :refunded

      t.timestamps
    end
  end
end
