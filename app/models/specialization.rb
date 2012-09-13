class Specialization < ActiveRecord::Base
  has_many :speeches
  attr_accessible :name
  
  validates :name, :presence => true
end
