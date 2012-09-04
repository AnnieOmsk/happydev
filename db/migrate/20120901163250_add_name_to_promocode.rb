class AddNameToPromocode < ActiveRecord::Migration
  def change
    add_column :promocodes, :name, :string
  end
end
