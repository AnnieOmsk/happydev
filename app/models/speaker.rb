class Speaker < ActiveRecord::Base
  belongs_to :city
  belongs_to :company
  has_many :speeches
  attr_accessible :first_name, :last_name, :email, :phone, :personal_url, :description, :city, :company,
                  :facebook, :github, :moikrug, :slideshare, :twitter, :vk

  validates_presence_of :first_name, :last_name
end
