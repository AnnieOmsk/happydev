class InvoiceEvent < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :event

  def price_with_discount
    return event.price if !event.discount || !invoice.promocode

    if promocode = Promocode.find_by_number(invoice.promocode)
      (100 + promocode.discount_value) * event.price / 100
    else
      event.price
    end
  end

  def self.not_paid
    where(:paid => false)
  end

  def self.all_paid?
    self.all.all?{ |e| e.paid? }
  end
end
