class Speech < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :section
  belongs_to :specialization
  attr_accessible :annotation, :description, :title, :speaker, :section, :specialization, :start_time, :timing,
                  :speaker_id, :section_id, :specialization_id, :permalink

  validates_presence_of :title, :speaker

  def end_time
    if start_time && timing
      start_time + timing.minutes
    else
      nil
    end
  end

  def time_range
    if start_time && end_time
      start_time.strftime("%H:%M") + ' - ' + end_time.strftime("%H:%M")
    else
      nil
    end
  end
end
