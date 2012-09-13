class Company < ActiveRecord::Base
  belongs_to :city
  has_many :speakers
  attr_accessible :name, :url, :city

  validates :name, :presence => true
end
