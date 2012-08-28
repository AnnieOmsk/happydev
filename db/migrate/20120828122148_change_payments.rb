class ChangePayments < ActiveRecord::Migration
  def change
    remove_column :payments, :user_id
    remove_column :payments, :expected_amount
    remove_column :payments, :paid
    remove_column :payments, :paid_amount
    add_column :payments, :invoice_id, :integer
    add_column :payments, :amount, :integer
  end
end
