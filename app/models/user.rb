class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  after_create :subscribe_to_mailchimp

  def subscribe_to_mailchimp
    @mailchimp = Mailchimp.new
    @mailchimp.subscribe_to_list(email)
  end
end
