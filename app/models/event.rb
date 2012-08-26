class Event < ActiveRecord::Base
  attr_accessible :name, :price, :master
  has_and_belongs_to_many :payments
end
