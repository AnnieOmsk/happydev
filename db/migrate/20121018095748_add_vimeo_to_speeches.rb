class AddVimeoToSpeeches < ActiveRecord::Migration
  def change
    add_column :speeches, :vimeo, :text
  end
end
