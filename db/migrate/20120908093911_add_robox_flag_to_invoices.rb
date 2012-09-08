class AddRoboxFlagToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :robox_flag, :boolean, :default => false
  end
end
