class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.boolean :status 
      t.integer :user_id
      t.integer :speech_id

      t.timestamps
    end
    add_index "likes", "user_id"
    add_index "likes", "speech_id"
  end
end
