class Stream < ActiveRecord::Base
  belongs_to :section
  attr_accessible :number, :section_id, :frame_width, :frame_height, :disable
  scope :only_enabled, where(:disable => false)
end
