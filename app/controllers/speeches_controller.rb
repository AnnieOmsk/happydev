class SpeechesController < ApplicationController

  caches_page :show

  def show
    @speech = Speech.find_by_permalink(params[:permalink])
    if @speech.blank?
      redirect_to root_url
    else
      @speaker = @speech.speaker
      @company = @speaker.company
    end
  end
end
