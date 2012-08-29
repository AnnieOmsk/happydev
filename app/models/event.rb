# encoding: utf-8
class Event < ActiveRecord::Base
  attr_accessible :name, :price, :master, :start_at, :end_at, :place
  has_many :invoice_events
  has_many :invoices, :through => :invoice_events

  def full_name
    [name, master, "#{price} рублей"].compact.join(', ')
  end
end
