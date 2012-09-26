class AddTwoColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :org, :boolean
    add_column :users, :served, :boolean, :default => false
  end
end
