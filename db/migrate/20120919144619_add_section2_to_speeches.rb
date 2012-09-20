class AddSection2ToSpeeches < ActiveRecord::Migration
  def change
    add_column :speeches, :section2_id, :integer
  end
end
