class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :user
      t.integer :amount
      t.datetime :expired_at

      t.timestamps
    end
    add_index :invoices, :user_id
  end
end
