class HomeController < ApplicationController

  caches_page :index, :speakers

  def index
    @speeches = Speech.joins([:speaker, :section])
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
end
