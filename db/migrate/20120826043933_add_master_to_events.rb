class AddMasterToEvents < ActiveRecord::Migration
  def change
    add_column :events, :master, :string
  end
end
