class AddOfertaToInvoice < ActiveRecord::Migration
  def change
    remove_column :users, :oferta
    add_column :invoices, :oferta, :boolean, :default => false
  end
end
