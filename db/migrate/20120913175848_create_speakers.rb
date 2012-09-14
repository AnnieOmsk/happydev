class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :personal_url
      t.string :twitter
      t.string :facebook
      t.string :vk
      t.string :github
      t.string :moikrug
      t.string :slideshare
      t.text :description
      t.references :city
      t.references :company

      t.timestamps
    end
    add_index :speakers, :city_id
    add_index :speakers, :company_id
  end
end
