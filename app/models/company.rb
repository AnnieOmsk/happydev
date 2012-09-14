class Company < ActiveRecord::Base
  belongs_to :city, :inverse_of => :companies
  has_many :speakers
  attr_accessible :name, :url, :city_id

  validates :name, :presence => true
end
