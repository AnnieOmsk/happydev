class AddClearingToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :clearing, :boolean, :default => false
  end
end
