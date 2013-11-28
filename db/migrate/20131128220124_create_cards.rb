class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :user, index: true
      t.string :stripe_token
      t.text :description

      t.timestamps
    end
  end
end
