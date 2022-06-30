class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.string :from_symbol
      t.string :to_symbol
      t.string :rate_symbol
      t.integer :user_id

      t.timestamps
    end
    add_index :rates, :user_id
  end
end
