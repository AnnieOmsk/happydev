class AddMasterClassToSpeeches < ActiveRecord::Migration
  def change
    add_column :speeches, :master_class, :boolean
  end
end
