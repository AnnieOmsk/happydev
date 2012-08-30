class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :payments
  has_many :invoice_events, :dependent => :destroy
  has_many :events, :through => :invoice_events

  attr_accessible :event_ids

  def all_invoice_events_paid?
    invoice_events.all?{ |e| e.paid? }
  end

  def check_invoice_events_paid
    overall_pay_amount = payments.map(&:amount).sum
    return if invoice_events.not_paid && overall_pay_amount < invoice_events.not_paid.map(&:event).map(&:price).min

    invoice_events.sort_by{ |i| i.event.priority }.each do |ie|
      if ie.paid?
        overall_pay_amount -= ie.event.price
      else
        if ie.event.priority == 0                       # if conference
          overall_pay_amount = check_and_set_paid(ie, overall_pay_amount)
        elsif ie.event.priority == 1                  # if lunch
          overall_pay_amount = check_and_set_paid(ie, overall_pay_amount)
        else                                          # if master-class
          overall_pay_amount = check_and_set_paid(ie, overall_pay_amount)
        end
      end
      break if invoice_events.all_paid? || (invoice_events.not_paid && overall_pay_amount < invoice_events.not_paid.map(&:event).map(&:price).min)
    end
  end

  private

  def check_and_set_paid(ie, overall_amount)
    if overall_amount >= ie.event.price
      ie.paid = true
      ie.save
    end
    overall_amount -= ie.event.price
  end
end
