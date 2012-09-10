class AddAmountToEachInvoiceEvent < ActiveRecord::Migration
  def change
    add_column :invoice_events, :paid_amount, :integer
  end
end
