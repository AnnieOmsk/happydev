class AddPositionToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :position, :string
  end
end
