class AddPaymentTypeToInvoices < ActiveRecord::Migration
  def change
    remove_column :invoices, :clearing
    add_column :invoices, :payment_type, :string
  end
end
