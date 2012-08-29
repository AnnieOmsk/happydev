class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :payments
  has_many :invoice_events
  has_many :events, :through => :invoice_events
end
