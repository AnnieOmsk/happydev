class SpeechesController < ApplicationController

  caches_page :show

  def show
    @speech = Speech.find_by_permalink(params[:permalink])
    @speaker = @speech.speaker
    @company = @speaker.company
  end
end
