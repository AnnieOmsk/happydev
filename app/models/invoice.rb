#encoding: utf-8

class Invoice < ActiveRecord::Base
  belongs_to :user
  has_many :payments
  has_many :invoice_events, :dependent => :destroy
  has_many :events, :through => :invoice_events

  attr_accessible :event_ids, :discount_status, :promocode, :oferta

  validates :oferta, :inclusion => { :in => [true], :message => "Условия оферты должны быть приняты" }

  def all_invoice_events_paid?
    invoice_events.all?{ |e| e.paid? }
  end

  def mark_invoice_events_paid
    # все платежи
    overall_pay_amount = payments.map(&:amount).sum

    # если есть неоплаченные invoice events и сумма оплаты меньше цены минимального неоплаченного эвента
    return if invoice_events.not_paid && overall_pay_amount < invoice_events.not_paid.map(&:price_with_discount).min

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
      # если нет неоплаченных invoice events или сумма оплаты меньше цены минимального неоплаченного эвента
      break if invoice_events.all_paid? || (invoice_events.not_paid && overall_pay_amount < invoice_events.not_paid.map(&:price_with_discount).min)
    end
  end

  private
  def check_and_set_paid(ie, overall_amount)
    price = ie.price_with_discount

    if overall_amount >= price
      ie.paid = true
      ie.save
    end
    overall_amount -= price
  end

  def self.drafting_invoice(user, options, promocode)
    invoice = user.build_invoice(options)
    if promocode.blank? || !Promocode.all.map(&:number).include?(promocode)
      invoice.amount = invoice.events.map(&:price).inject(:+)
    else
      invoice.discount_status = true
      invoice.promocode = promocode
      invoice.amount = counting_amount_with_discount(invoice, user, promocode)
    end
    invoice.expired_at = 3.day.from_now
    invoice.code = Time.now.to_i + user.id
    invoice
  end

  def self.counting_amount_with_discount(invoice, user, promocode)
    tmp_amount = invoice.events.select{|e| e.discount != false }.map(&:price).inject(:+) || 0
    tmp_amount = tmp_amount + (tmp_amount * (Promocode.find_by_number(promocode).discount_value/100.0))   # can handle +50% and -10%
    tmp_amount += invoice.events.select{|e| e.discount == false }.map(&:price).inject(:+) || 0
  end

  def self.set_flash_message_include_promocode(promocode)
    promo_name = Promocode.find_by_number(promocode).name
    if promo_name == "FROM_FRIEND"
      return "Спасибо тебе большое за дополнительную сумму. Ты настоящий друг!"
    else
      return "Ура, ты получил скидку!!!"
    end
  end
end
