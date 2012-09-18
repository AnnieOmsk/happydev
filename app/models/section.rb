# encoding: utf-8
class Section < ActiveRecord::Base
  has_many :speeches
  attr_accessible :hall, :name, :speech_ids, :description

  validates :name, :presence => true
  scope :without_general, where("name not in (?)", "Общий")
end
