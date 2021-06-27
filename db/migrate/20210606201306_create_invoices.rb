class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_table :invoices do |t|
      t.string :code
      t.integer :kind

      t.timestamps
    end
  end
end
