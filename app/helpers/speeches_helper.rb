# encoding: utf-8

module SpeechesHelper
  def icon_for_speakers speech, options = {}, link_options = {}
    spec_hash = {"Разработка" => "developer", "Дизайн" => "designer", "Управление" => "manager", "Общий" => "general", "Стартап-порка" => "startup_porka"}
    spec_hash = apply_icon_theme(spec_hash, options[:theme]) if options[:theme]
     
    if options[:second]
     "#{spec_hash[speech.specialization2.name]}"
    else
      if speech.specialization
        "#{spec_hash[speech.specialization.name]}"
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

  private
  def apply_icon_theme(hash, suffix)
    hash.each {|key, value| hash[key] = value + '_' + suffix}
  end
end
