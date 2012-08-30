# encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

Event.delete_all
Event.create(:name => "Конференция HappyDev",
             :start_at => "2012-09-29 10:00",
             :end_at => "2012-09-30 18:00",
             :price => 2)
Event.create(:name => "Обед",
             :price => 4)