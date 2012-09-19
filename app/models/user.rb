# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :first_name, :last_name, :company, :city, :professional,
                  :password, :password_confirmation, :remember_me, :promocode, :oferta, :student

  has_one :invoice

  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :password, :presence => true
  validates :password_confirmation, :presence => true
  validates :email, :presence => true, :uniqueness => true
  validates :professional, :presence => true

  after_create :subscribe_to_mailchimp, :deliver_notification

  def paid?
    invoice.all_invoice_events_paid? if invoice
  end

  def subscribe_to_mailchimp
    @mailchimp = Mailchimp.new
    @mailchimp.subscribe_to_list(email, first_name, last_name)
  end

  def deliver_notification
    Mailer.send_notification(email).deliver!
  end  
end
