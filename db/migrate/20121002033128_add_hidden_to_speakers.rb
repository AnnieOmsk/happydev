class AddHiddenToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :hidden, :boolean, :default => false
  end
end
