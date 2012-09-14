class AddSpeakersToSpeech < ActiveRecord::Migration
  def change
    add_column :speeches, :speaker2_id, :integer
    add_column :speeches, :speaker3_id, :integer
  end
end
