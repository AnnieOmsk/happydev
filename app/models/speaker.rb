class Speaker < ActiveRecord::Base
  belongs_to :city
  belongs_to :company
  has_many :speeches
  attr_accessible :first_name, :last_name, :email, :phone, :description, :city, :company, :position, :city_id, :company_id, :speech_ids,
                  :photo_url, :personal_url, :facebook, :github, :moikrug, :slideshare, :twitter, :vk

  validates_presence_of :first_name, :last_name

  scope :with_photos, where('photo_url != ?', '')

  def secondary_speeches
    Speech.where('speaker2_id = ?', id)
  end
  
  def self.without_training_masters
    includes(:speeches).merge(Speech.without_master_classes).to_a.uniq
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def personal_url_or_moikrug_url
    personal_url.blank? ? moikrug : personal_url
  end
end
