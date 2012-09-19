class AddSystemNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :system_name, :string
  end
end
