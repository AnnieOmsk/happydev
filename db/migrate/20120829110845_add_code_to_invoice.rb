class AddCodeToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :code, :string
  end
end
