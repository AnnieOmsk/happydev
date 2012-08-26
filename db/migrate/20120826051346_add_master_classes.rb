#encoding: utf-8

class AddMasterClasses < ActiveRecord::Migration
  def up
    Event.create(:name => 'Конференция HappyDev', :price => 2000)
    Event.create(:name => 'Certified Scrum Master', :master => 'Алексей Кривицкий', :price => 30000)
    Event.create(:name => 'Мастер класс', :master => 'Александр Косс', :price => 15000)
  end
end
