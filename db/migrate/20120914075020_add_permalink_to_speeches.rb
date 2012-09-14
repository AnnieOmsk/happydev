class AddPermalinkToSpeeches < ActiveRecord::Migration
  def change
    add_column :speeches, :permalink, :string
    add_index :speeches, :permalink
  end
end
