class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :number
      t.integer :frame_width
      t.integer :frame_height
      t.boolean :disable, :default => false
      t.references :section

      t.timestamps
    end
    add_index :streams, :section_id
  end
end
