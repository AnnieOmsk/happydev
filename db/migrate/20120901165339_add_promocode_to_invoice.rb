class AddPromocodeToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :promocode, :string
  end
end
