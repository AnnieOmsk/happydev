class AddOfertaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oferta, :boolean, :default => false
  end
end
