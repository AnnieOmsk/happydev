class AddSpecialization2ToSpeeches < ActiveRecord::Migration
  def change
    add_column :speeches, :specialization2_id, :integer
  end
end
