class CreatePromocodes < ActiveRecord::Migration
  def change
    create_table :promocodes do |t|
      t.integer :discount_value
      t.string :number

      t.timestamps
    end
  end
end
