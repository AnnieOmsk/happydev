class ChangePaidFromInvoiceEvents < ActiveRecord::Migration
  def change
    change_column :invoice_events, :paid, :boolean, :default => false
  end
end
