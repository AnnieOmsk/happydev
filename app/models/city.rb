class City < ActiveRecord::Base
  has_many :companies
  attr_accessible :name
  validates :name, :presence => true
end
