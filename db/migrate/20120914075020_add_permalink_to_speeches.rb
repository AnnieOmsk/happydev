class AddPermalinkToSpeeches < ActiveRecord::Migration
  def change
    add_column :speeches, :permalink, :string
  end
  add_index :speeches, :permalink
end
