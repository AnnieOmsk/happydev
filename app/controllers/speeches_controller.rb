class SpeechesController < ApplicationController
  def show
    @speech = Speech.find_by_permalink(params[:permalink])
    @speaker = @speech.speaker
    @company = @speaker.company
  end
end
