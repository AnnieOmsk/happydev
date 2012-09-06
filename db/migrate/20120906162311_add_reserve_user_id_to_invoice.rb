class AddReserveUserIdToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :reserve_user_id, :integer
  end
end
