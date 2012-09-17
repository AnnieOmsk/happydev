class AddTimeFieldsToSpeeches < ActiveRecord::Migration
  def change
    add_column :speeches, :start_time, :datetime
    add_column :speeches, :timing, :integer
  end
end
