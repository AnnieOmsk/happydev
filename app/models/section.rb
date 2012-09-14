class Section < ActiveRecord::Base
  has_many :speeches
  attr_accessible :hall, :name, :speech_ids, :description

  validates :name, :presence => true
end
