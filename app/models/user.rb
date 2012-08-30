class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :name, :student, :company, :city, :professional, :password, :password_confirmation, :remember_me

  has_one :invoice
  
  validates :name, :presence => true
  validates :professional, :presence => true
  validates :email, :presence => true, :uniqueness => true


  after_create :subscribe_to_mailchimp, :deliver_notification

  def subscribe_to_mailchimp
    @mailchimp = Mailchimp.new
    @mailchimp.subscribe_to_list(email)
  end

  def deliver_notification
    Mailer.send_notification(email).deliver!
  end
end
