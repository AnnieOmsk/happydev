class Speaker < ActiveRecord::Base
  belongs_to :city
  belongs_to :company
  has_many :speeches
  attr_accessible :first_name, :last_name, :email, :phone, :description, :city, :company, :position, :city_id, :company_id, :speech_ids,
                  :photo_url, :personal_url, :facebook, :github, :moikrug, :slideshare, :twitter, :vk

  validates_presence_of :first_name, :last_name

  scope :with_photos, where('photo_url != ?', '')

  def full_name
    [first_name, last_name].join(' ')
  end

  def personal_url_or_moikrug_url
    personal_url ? personal_url : moikrug
  end
end
