class City < ActiveRecord::Base
  has_many :companies
  has_many :speakers
  attr_accessible :name
  validates :name, :presence => true
end
