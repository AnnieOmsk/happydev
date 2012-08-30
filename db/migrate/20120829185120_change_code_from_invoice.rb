class ChangeCodeFromInvoice < ActiveRecord::Migration
  def change
    change_column :invoices, :code, :integer
  end
end
