class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :speech

  attr_accessible :status, :speech_id
end
