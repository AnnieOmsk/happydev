# encoding: utf-8
class InvoicesController < ApplicationController
  include HttpAuthenticable
  before_filter :authenticate

  before_filter :authenticate_user!, :only => [:new, :create, :show]
  before_filter :find_invoice, :only => [:new, :show, :success, :fail]

  def new
    if @invoice
      redirect_to invoice_path
    else
      @invoice = current_user.build_invoice
      @events = Event.all
      gon_hash = {}
      @events.each { |e| gon_hash[e.id] = e.price }
      gon.event_prices = gon_hash
    end
  end

  def create
    if params[:invoice]["event_ids"].all?{ |i| i.blank? }   # if events not selected
      redirect_to new_invoice_path
    else
      @invoice = current_user.build_invoice(params[:invoice])
      @invoice.amount = @invoice.events.map(&:price).inject(:+)     # write overall price
      @invoice.expired_at = 3.day.from_now
      @invoice.code = rand(10 ** 10)                                # Only digits!!!!! (SecureRandom.hex(8))
      if @invoice.save
        if @invoice.invoice_events
          @invoice.invoice_events.map { |e| e.paid = false; e.save }   # setup events' paid field = false
        end
        Mailer.send_choice_part_conf(current_user.email, @invoice.events, @invoice.amount, @invoice.expired_at).deliver!
        flash[:notice] = "Заказ добавлен. Теперь вы можете оплатить его"
      else
        flash[:notice] = 'Ошибка при регистрации'
      end
      redirect_to invoice_path
    end
  end

  def show
    unless @invoice
      redirect_to new_invoice_path
    end
  end

  def demopage
  end

  private

  def find_invoice
    @invoice = current_user.invoice
  end
end
