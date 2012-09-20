# encoding: utf-8
class Event < ActiveRecord::Base
  attr_accessible :name, :price, :master, :start_at, :end_at, :place, :priority, :discount
  has_many :invoice_events
  has_many :invoices, :through => :invoice_events

  before_create :set_priority

  scope :for_student, where(:system_name => [:conference_student, :dinner]).order('price desc')
  scope :for_all, where(:system_name => [:conference_main, :dinner]).order('price desc')

  def full_name
    [name, master, "#{price} руб."].compact.join(', ')
  end

  def full_name_with_price
    [name, master, "#{price}"].compact.join(', ')
  end

  def full_name_without_price
    [name, master].reject {|e| e.blank?}.join(', ')
  end

  # Set priority for events
  def set_priority
    es = Event.all.map(&:priority)
    if es.max.nil?
      self.priority = 0
    else
      self.priority = es.max + 1
    end
  end
end
