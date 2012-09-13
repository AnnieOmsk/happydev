class Section < ActiveRecord::Base
  has_many :speeches
  attr_accessible :hall, :name

  validates :name, :presence => true
end
