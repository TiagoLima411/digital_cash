class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :category, foreign_key: true
      t.references :invoice, foreign_key: true
      t.string :name
      t.string :bar_code
      t.integer :purchase_price_cents
      t.integer :sale_price_cents
      t.integer :spread_cents
      t.decimal :spread_fee, precision: 5, scale: 2

      t.timestamps
    end
  end
end
