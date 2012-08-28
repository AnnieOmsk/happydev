class CreateInvoicesEventsJoinTable < ActiveRecord::Migration
  def change
    create_table :events_invoices, :id => false do |t|
      t.integer :invoice_id
      t.integer :event_id
    end
    add_index "events_invoice", "invoice_id"
    add_index "events_invoice", "event_id"
  end
end
