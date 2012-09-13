class Company < ActiveRecord::Base
  belongs_to :city
  attr_accessible :name, :url, :city

  validates :name, :presence => true
end
