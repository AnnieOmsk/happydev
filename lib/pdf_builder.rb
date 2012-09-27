# coding: utf-8
class PdfBuilder < ActionController::Base
  include ApplicationHelper
  include SpeechesHelper
  BADGE_TYPES = {
    'Разработка' => 'developer',
    'Дизайн' => 'designer',
    'Управление' => 'manager'
  }

  def create_program_for_user(user)
    @speeches = Speech.joins([:speaker, :section])
    @sections = Section.first(3)
    @user = user

    pdf = render_to_string options_for_template("file.pdf", "programs/show")

    save_path = Rails.root.join("pdfs/#{@user.full_name}.pdf")    
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end

  def create_badge_for_user(user)
    @user = user
    pdf = render_to_string options_for_template("badge.pdf", "badges/badge")
    
    background_path = Rails.root.join("badges/tmp/background_#{@user.id}.pdf")    
    File.open(background_path, 'wb') do |file|
      file << pdf
    end
    
    badge_name = 
      if user.professional.present?
        BADGE_TYPES[user.professional]
      else
        'developer'
      end
     
    badge_path = Rails.root.join('badges', 'templates', "#{badge_name}.pdf")
    pdf_path = Rails.root.join('badges', 'final', "#{@user.id}.pdf")
    system "pdftk #{badge_path} stamp #{background_path} output #{pdf_path}"
  end

  private
  def options_for_template(name, template)
     {
      :pdf => name,
      :encoding => 'utf8',
      :layout => false,
      :template => template,
      :dpi => '300',
      :margin => {:top => '50mm',
                  :bottom => '0mm',
                  :left => '0mm',
                  :right => '0mm'},
      # :page_size => 'A4',
      :page_height => '110',
      :page_width => '90',
      :no_background => true
    }
  end
end
