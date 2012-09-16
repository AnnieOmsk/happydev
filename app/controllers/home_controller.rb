class HomeController < ApplicationController

  def index
    @speeches = Speech.joins([:speaker, :section])
    @sections = Section.first(3)
  end
end
