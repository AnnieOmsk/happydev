class RemoveNameFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :name
    change_column :users, :first_name, :string, :null => false, :default => ""
    change_column :users, :last_name, :string, :null => false, :default => ""
  end
end
