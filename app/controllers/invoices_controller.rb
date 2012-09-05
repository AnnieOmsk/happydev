# encoding: utf-8
class InvoicesController < ApplicationController
  # include HttpAuthenticable
  # before_filter :authenticate

  before_filter :authenticate_user!, :only => [:new, :create, :show]
  before_filter :find_invoice, :only => [:new, :show, :success, :fail]

  def new
    # if @invoice
    #   redirect_to invoice_path
    # else
      @invoice = current_user.build_invoice
      @events = Event.all
      gon_hash = {}
      @events.each { |e| gon_hash[e.id] = e.price }
      gon.event_prices = gon_hash
    # end
  end

  def create
    if params[:invoice]["event_ids"].all?{ |i| i.blank? }    # if events not selected
      redirect_to new_invoice_path
    else
      @invoice = Invoice.drafting_invoice(current_user, params[:invoice], params[:promocode])
      if @invoice.save
        # Mailer.send_choice_part_conf(current_user.email, @invoice.events, @invoice.amount, @invoice.expired_at).deliver!
        if @invoice.discount_status
          flash[:notice] = Invoice.set_flash_message_include_promocode(params[:promocode])

        else
          # flash[:notice] = "Заказ добавлен. Теперь ты можешь оплатить его"
          redirect_to invoice_path
        end
      else
        @events = Event.all
        gon_hash = {}
        @events.each { |e| gon_hash[e.id] = e.price }
        gon.event_prices = gon_hash
        render(:action => :new) && return
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
