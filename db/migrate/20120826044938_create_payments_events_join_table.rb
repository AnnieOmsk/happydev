class CreatePaymentsEventsJoinTable < ActiveRecord::Migration
  def change
    create_table :events_payments, :id => false do |t|
      t.integer :payment_id
      t.integer :event_id
    end
    add_index "events_payments", "payment_id"
    add_index "events_payments", "event_id"
  end
end
