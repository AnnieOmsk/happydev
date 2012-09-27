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
    @speeches = Speech.includes([:speaker, :section])
    @sections = Section.first(3)
    @user = user

    %w(program29 program30).each do |template|
      pdf = render_to_string options_for_programs("programs/#{template}")
      
      save_path = Rails.root.join("pdfs/#{@user.full_name} - #{template}.pdf")    
      File.open(save_path, 'wb') do |file|
        file << pdf
      end
    end
  end

  def create_badge_for_user(user)
    @user = user
    pdf = render_to_string options_for_badges
    
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
  def default_print_options
     {
      :encoding => 'utf8',
      :layout => false,
      :dpi => '300',
    }
  end

  def options_for_programs(template)
    default_print_options.merge!( :pdf => 'file.pdf',
                                  :template => template,
                                  :margin => {:top => '0mm',
                                              :bottom => '0mm',
                                              :left => '0mm',
                                              :right => '0mm'},
                                  :page_size => 'A4')
  end

  def options_for_badges
    default_print_options.merge!( :pdf => "badge.pdf",
                                  :template => "badges/badge",
                                  :margin => {:top => '50mm',
                                              :bottom => '0mm',
                                              :left => '0mm',
                                              :right => '0mm'},
                                  :page_height => '110',
                                  :page_width => '90',
                                  :no_background => true)

  end
end
