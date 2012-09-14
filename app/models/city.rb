class City < ActiveRecord::Base
  has_many :companies, :inverse_of => :city
  has_many :speakers
  attr_accessible :name, :speaker_ids, :company_ids
  validates :name, :presence => true
end
