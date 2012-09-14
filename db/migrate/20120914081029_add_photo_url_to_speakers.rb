class AddPhotoUrlToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :photo_url, :string
  end
end
