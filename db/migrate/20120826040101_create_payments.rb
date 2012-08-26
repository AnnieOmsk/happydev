class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :user
      t.integer :amount

      t.timestamps
    end
    add_index :payments, :user_id
  end
end
