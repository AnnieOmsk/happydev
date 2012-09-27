# encoding: utf-8

module SpeechesHelper
  def icon_for_speakers(speech, options = {}, link_options = {})
    spec_hash = {"Разработка" => "developer", "Дизайн" => "designer", "Управление" => "manager", "Общий" => "general", "Стартап-порка" => "startup_porka"}
    spec_hash = apply_icon_theme(spec_hash, options[:theme]) if options[:theme]
    
    if options[:program] && speech.section.name == "Общий"
      "#{spec_hash[speech.section.name]}" 
    elsif options[:second]
      "#{spec_hash[speech.specialization2.name]}"
    else
      if speech.specialization
        "#{spec_hash[speech.specialization.name]}"
      end
    end
  end

  # old. using by pdf builder only
  def image_for_speakers speech, options = {}, link_options = {}
    spec_hash = {"Разработка" => "developer", "Дизайн" => "designer", "Управление" => "manager", "Общий" => "general", "Стартап-порка" => "startup_porka"}
    spec_hash = apply_icon_theme(spec_hash, options[:theme]) if options[:theme]
     
    if options[:second]
      image = "pdf_program_icons/#{spec_hash[speech.specialization2.name]}.svg"
      wicked_pdf_image_tag image, link_options.merge!(:size => '20x20')
    else
      if speech.specialization
        image = "pdf_program_icons/#{spec_hash[speech.specialization.name]}.svg"
        wicked_pdf_image_tag image, link_options.merge!(:size => '20x20')
      end
    end
  end

  def url_for_speakers_name speech, options = {}
    array = []
    speech.speakers.map do |sp|
      array << if sp.personal_url.blank?
                  sp.full_name
                else
                  link_to sp.full_name, sp.personal_url, options.merge!(:target => "_blank")
                end
    end
    array.join(", ").html_safe
  end

  def section_and_spec_names
    sections = []
    specializations = []
    Section.without_general.each do |section|
       sections << section.name
    end
    Specialization.without_general.each do |spec|
       specializations << spec.name
    end
    hash = {}
    hash[:section] = sections
    hash[:specialization] = specializations
    hash
  end

  def link_for_speech speech
    options = { :class => 'b-reporters__person-theme-link',
                :data => { :section => speech.section.name,
                           :specialization => speech.specialization.name } }
    options.merge!(:"data-specialization2" => speech.specialization2.name) if speech.specialization2
    options.merge!(:"data-section2" => speech.section2.name) if speech.section2
    link_to "\&laquo;#{speech.title}&raquo;".html_safe, "/speakers/#{speech.permalink}", options
  end

  private
  def apply_icon_theme(hash, suffix)
    hash.each {|key, value| hash[key] = value + '_' + suffix}
  end
end
