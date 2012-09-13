class Section < ActiveRecord::Base
  attr_accessible :hall, :name

  validates :name, :presence => true
end
