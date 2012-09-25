# coding: utf-8
class Speech < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :speaker2, :class_name => 'Speaker'
  belongs_to :speaker3, :class_name => 'Speaker'
  belongs_to :section
  belongs_to :section2, :class_name => 'Section'
  belongs_to :specialization
  belongs_to :specialization2, :class_name => 'Specialization'
  attr_accessible :annotation, :description, :title, :speaker, :section, :specialization, :start_time, :timing,
                  :speaker_id, :speaker2_id, :speaker3_id, :section_id, :section2_id, :specialization_id, :specialization2_id, :permalink

  validates_presence_of :title, :speaker

  scope :without_startup_battles, includes(:specialization).where('specialization_id is ? or specializations.name != ?', nil, 'Стартап-порка')

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

  def speakers
    [speaker, speaker2, speaker3].compact
  end

  def has_multiple_speakers?
    speakers.size > 1
  end

  def ne_porka?
    if specialization
      specialization.name != 'Стартап-порка'
    else
      false
    end
  end

  def has_one_speaker?
    !has_multiple_speakers?
  end

  def all_speakers_names
    speakers.map {|s| s.full_name if s}.join(', ')
  end
end
