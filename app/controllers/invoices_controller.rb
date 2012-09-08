# encoding: utf-8
class InvoicesController < ApplicationController
  # include HttpAuthenticable
  # before_filter :authenticate

  before_filter :authenticate_user!, :except => :delete
  before_filter :find_invoice, :only => [:new, :show, :edit, :update, :move_to_robokassa]

  def new
    if @invoice
      redirect_to invoice_path
    else
      @invoice = current_user.build_invoice
      @events = get_all_events
    end
  end

  def create
    if params[:invoice]["event_ids"].all?{ |i| i.blank? }               # if events not selected
      redirect_to new_invoice_path
    else
      
      if current_user.invoice && current_user.invoice.marked_as_moved_to_robokassa?
        redirect_to invoice_path
      else

        @invoice = Invoice.drafting_invoice(current_user, params[:invoice])
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
          @events = get_all_events
          render(:action => :new) && return
        end
      end
    end
  end

  def show
    unless @invoice
      redirect_to new_invoice_path
    end
  end

  def edit
    @events = get_all_events
  end

  def update
    if params[:invoice]["event_ids"].all?{ |i| i.blank? }    # if events not selected
      redirect_to edit_invoice_path
    else
      @invoice.attributes = params[:invoice]
      @invoice.checking_and_counting_amount

      if @invoice.save
        # Mailer.send_choice_part_conf(current_user.email, @invoice.events, @invoice.amount, @invoice.expired_at).deliver!
        if @invoice.discount_status
          flash[:notice] = Invoice.set_flash_message_include_promocode(params[:promocode])
        else
          # flash[:notice] = "Заказ добавлен. Теперь ты можешь оплатить его"
        end
        redirect_to invoice_path
      else
        @events = get_all_events
        render(:action => :edit) && return
      end
      # redirect_to invoice_path
    end
  end

  def move_to_robokassa
    if @invoice.mark_as_gone_to_robokassa!
      render :text => 'success', :status => 200
    else
      render :text => 'error', :status => 500
    end
  end

  private

  def find_invoice
    @invoice = current_user.invoice
  end

  def get_all_events
    events = Event.all
    gon_hash = {}
    events.each { |e| gon_hash[e.id] = e.price }
    gon.event_prices = gon_hash
    events
  end
end
