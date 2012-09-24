class PdfBuilder < ActionController::Base
  include ApplicationHelper
  include SpeechesHelper

  def create_program_for_user(user)
    @speeches = Speech.joins([:speaker, :section])
    @sections = Section.first(3)
    @user = user

    pdf = render_to_string options_for_template("file.pdf")

    save_path = Rails.root.join("pdfs/#{@user.full_name}.pdf")    
    File.open(save_path, 'wb') do |file|
      file << pdf
    end
  end

  private
  def options_for_template(name)
     {
      :pdf => name,
      :encoding => 'utf8',
      :layout => false,
      :template => "programs/show",
      :dpi => '300',
      :margin => {:top => '5mm',
                  :bottom => '0mm',
                  :left => '5mm',
                  :right => '0mm'},
      :page_size => 'A4'
    }
  end
end
