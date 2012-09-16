# encoding: utf-8

module SpeechesHelper
  def icon_for_speakers speech, spec2 = nil
    spec_hash = {"Разработка" => "developer", "Дизайн" => "designer", "Управление" => "manager", "Общий" => "general"}
    if spec2
      image = "#{spec_hash[speech.specialization2.name]}.png"
      image_tag image, :size => "20x20"
    else
      if speech.specialization
        image = "#{spec_hash[speech.specialization.name]}.png"
        image_tag image, :size => "20x20"
      end
    end
  end

  def url_for_speakers_name speech
    array = []
    speech.speakers.map do |sp|
      array << if sp.personal_url.blank?
                  sp.full_name
                else
                  link_to sp.full_name, sp.personal_url, { :target => "_blank" }
                end
    end
    array.join(", ").html_safe
  end
end