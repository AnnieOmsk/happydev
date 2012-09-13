class Speech < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :section
  belongs_to :specialization
  attr_accessible :annotation, :description, :title, :speaker, :section, :specialization

  validates_presence_of :title, :speaker
end
