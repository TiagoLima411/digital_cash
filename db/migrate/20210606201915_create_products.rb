class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.references :invoice, foreign_key: true
      t.string :name
      t.string :bar_code
      t.integer :purchase_price
      t.integer :sale_price
      t.integer :spread
      t.decimal :spread_fee

      t.timestamps
    end
  end
end
