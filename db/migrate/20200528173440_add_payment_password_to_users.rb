class AddPaymentPasswordToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :payment_password, :string, after: :encrypted_password
  end
end
