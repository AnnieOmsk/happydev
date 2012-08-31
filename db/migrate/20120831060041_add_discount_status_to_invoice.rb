class AddDiscountStatusToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :discount_status, :boolean, :default => false
  end
end
