class ChangeAmountFieldInPayments < ActiveRecord::Migration
  def up
    rename_column :payments, :amount, :expected_amount
    add_column :payments, :paid_amount, :integer
  end

  def down
    rename_column :payments, :expected_amount, :amount
    remove_column :payments, :paid_amount
  end
end
