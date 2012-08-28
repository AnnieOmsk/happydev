# encoding: utf-8
class Event < ActiveRecord::Base
  attr_accessible :name, :price, :master
  has_and_belongs_to_many :invoices

  def full_name
    [name, master, "#{price} рублей"].compact.join(', ')
  end
end
