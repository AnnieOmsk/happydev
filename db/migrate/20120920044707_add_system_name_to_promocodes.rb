class AddSystemNameToPromocodes < ActiveRecord::Migration
  def change
    add_column :promocodes, :system_name, :string
    Promocode.find_by_name('Sponsors').update_attribute(:system_name, 'sponsors')
    Promocode.find_by_name('Partners').update_attribute(:system_name, 'partners')
  end
end
