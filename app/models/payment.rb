class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :invoice
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

  def update_expected_amount!
    self.expected_amount = current_price
    save
  end
  
  def update_paid_amount!(value)
    self.paid_amount = value
    save
  end
end
