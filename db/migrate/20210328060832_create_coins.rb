class CreateCoins < ActiveRecord::Migration[6.1]
  def change
    create_table :coins do |t|
      t.string :symbol
      t.integer :user_id
      t.decimal :cost_per
      t.decimal :amount_owned
      t.belongs_to :market
      t.timestamps
    end
    add_index :coins, :user_id
  end
end
