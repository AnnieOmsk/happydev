class ProgramsController < ApplicationController
  def program29
    @speeches = Speech.includes([:speaker, :section])
    @sections = Section.first(3)
    @user = User.last
  end
  
  def program30
    @speeches = Speech.includes([:speaker, :section])
    @sections = Section.first(3)
    @user = User.last
  end
end
