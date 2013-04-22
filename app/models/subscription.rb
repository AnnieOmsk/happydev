class Subscription < ActiveRecord::Base
  attr_accessible :email
  validates :email, presence: true,
                    format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }

  after_create :send_to_mailchimp

  def send_to_mailchimp
    Mailchimp.new.subscribe_to_news(email)
  end
end
