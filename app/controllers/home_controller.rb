class HomeController < ApplicationController

  def index
    @speeches = Speech.joins([:speaker, :section])
  end
end
