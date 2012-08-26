class Payment < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :events
  attr_accessible :amount
end
