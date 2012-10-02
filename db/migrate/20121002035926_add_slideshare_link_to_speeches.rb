class AddSlideshareLinkToSpeeches < ActiveRecord::Migration
  def change
    add_column :speeches, :slideshare_embed_code_id, :string
  end
end
