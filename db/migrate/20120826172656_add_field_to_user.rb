class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :null => false
    add_column :users, :company, :string
    add_column :users, :city, :string
    add_column :users, :professional, :string
  end
end
