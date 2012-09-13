# encoding: utf-8
class InvoicesController < ApplicationController
  # include HttpAuthenticable
  # before_filter :authenticate

  # before_filter :authenticate_user!, :except => :delete
  before_filter :find_or_new_invoice, :only => [:new, :show, :clearing]

  def new
    # if @invoice.new_record?
    # @invoice = current_user.build_invoice
    @events = Event.all
    gon_hash = {}
    @events.each { |e| gon_hash[e.id] = e.price }
    gon.event_prices = gon_hash
    # else
    #   redirect_to invoice_path
    # end
  end

  def create
    if !params[:invoice]["event_ids"] # && params[:invoice]["event_ids"].all?{ |i| i.blank? }    # if events not selected
      redirect_to new_invoice_path
    else
      @invoice = Invoice.drafting_invoice(current_user, params[:invoice], params[:promocode])
      @invoice.reserve_user_id = current_user.id

      if @invoice.save

        # Mailer.send_choice_part_conf(current_user.email, @invoice.events, @invoice.amount, @invoice.expired_at).deliver!
        if @invoice.discount_status
          flash[:notice] = Invoice.set_flash_message_include_promocode(params[:promocode])
        else
          # flash[:notice] = "Заказ добавлен. Теперь ты можешь оплатить его"
        end
        redirect_to invoice_path
      else
        @events = Event.all
        gon_hash = {}
        @events.each { |e| gon_hash[e.id] = e.price }
        gon.event_prices = gon_hash
        render(:action => :new) && return
      end
      # redirect_to invoice_path
    end
  end

  # def show
  #   unless @invoice
  #     redirect_to new_invoice_path
  #   end
  # end

  def clearing
    if params[:state]
      if @invoice.mark_select_clearing(params[:state])
        render :text => 'success', :status => 200
      else
        render :text => 'error', :status => 500
      end
    end
  end

  private

  def find_or_new_invoice
    if current_user && current_user.invoice
      @invoice = current_user.invoice
    else
      @user = User.new
      @invoice = Invoice.new
    end
  end
end
