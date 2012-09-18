# encoding: utf-8
class Specialization < ActiveRecord::Base
  has_many :speeches
  attr_accessible :name
  
  validates :name, :presence => true

  scope :without_general, where("name not in (?)", ["Общий", "Стартап-порка"])
end
