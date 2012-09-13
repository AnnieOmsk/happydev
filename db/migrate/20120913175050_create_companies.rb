class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.references :city
      t.string :url

      t.timestamps
    end
    add_index :companies, :city_id
  end
end
