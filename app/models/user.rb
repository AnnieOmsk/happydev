# encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :name, :student, :company, :city, :professional, :password, :password_confirmation, :remember_me, :promocode, :oferta

  has_one :invoice

  validates :name, :presence => true
  validates :professional, :presence => true
  validates :email, :presence => true, :uniqueness => true

  before_create :split_name!
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
  
  # split user name to first_name and last_name
  # if user enter only one first_name, last_name will be nil
  def split_name!
    array = name.split
    self.first_name, self.last_name = array
  end
end
