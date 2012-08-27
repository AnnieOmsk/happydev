class Payment < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :events
  
  attr_accessible :event_ids

  # return price of selected events in current day pricings
  def current_price
    events.inject(0) { |sum, event| sum + event.price } 
  end

  # mark payment as paid
  def approve!
    self.paid = true
    save
  end

  def update_amount!(value)
    self.amount = value
    save
  end
end
