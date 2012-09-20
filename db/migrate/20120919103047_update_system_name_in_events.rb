# coding: utf-8
class UpdateSystemNameInEvents < ActiveRecord::Migration
  def up
    Event.find_by_name('Конференция HappyDev').update_attribute(:system_name, :conference_main)
    Event.find_by_name('Обед').update_attribute(:system_name, :dinner)
    Event.find_by_name('Конференция HappyDev (для студента)').update_attribute(:system_name, :conference_student)
  end

  def down
  end
end
