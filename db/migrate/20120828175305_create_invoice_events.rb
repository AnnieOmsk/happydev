class CreateInvoiceEvents < ActiveRecord::Migration
  def change
    create_table :invoice_events do |t|
      t.integer :invoice_id
      t.integer :event_id
      t.boolean :paid

      t.timestamps
    end
    add_index "invoice_events", "invoice_id"
    add_index "invoice_events", "event_id"
  end
end
