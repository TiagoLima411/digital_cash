class CreateOutgoings < ActiveRecord::Migration[5.2]
  def change
    create_table :outgoings do |t|
      t.references :user, foreign_key: true
      t.integer :outtype
      t.integer :value_cents
      t.string :description

      t.timestamps
    end
  end
end
