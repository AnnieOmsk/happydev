class CreateSpeeches < ActiveRecord::Migration
  def change
    create_table :speeches do |t|
      t.string :title
      t.text :annotation
      t.text :description
      t.references :speaker
      t.references :section
      t.references :specialization

      t.timestamps
    end
    add_index :speeches, :speaker_id
    add_index :speeches, :section_id
    add_index :speeches, :specialization_id
  end
end
