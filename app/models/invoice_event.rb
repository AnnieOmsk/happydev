class InvoiceEvent < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :event

  def self.not_paid
    where(:paid => false)
  end

  def self.all_paid?
    self.all.all?{ |e| e.paid? }
  end
end
