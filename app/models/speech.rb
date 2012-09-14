class Speech < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :section
  belongs_to :specialization
  attr_accessible :annotation, :description, :title, :speaker, :section, :specialization, :start_time, :timing,
                  :speaker_id, :section_id, :specialization_id, :permalink

  validates_presence_of :title, :speaker
end
