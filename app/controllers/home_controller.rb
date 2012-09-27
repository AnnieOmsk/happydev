class HomeController < ApplicationController
  include HttpAuthenticable
  before_filter :authenticate, :only => :stream

  caches_page :index, :speakers, :stream

  def index
    @speeches = Speech.includes([:speaker, :section])
    @sections = Section.first(3)
  end

  def about
    redirect_to "/"
  end

  def program
    redirect_to "/"
  end

  def speakers
  end

  def stream
  end
end
