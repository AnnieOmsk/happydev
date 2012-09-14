class Section < ActiveRecord::Base
  has_many :speeches
  attr_accessible :hall, :name, :speech_ids

  validates :name, :presence => true
end
