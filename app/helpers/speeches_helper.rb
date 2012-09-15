# encoding: utf-8

module SpeechesHelper
  def icon_for_speakers speech
    spec_hash = {"Разработка" => "developer", "Дизайн" => "designer", "Управление" => "manager"}
    if speech.specialization
      image = "#{spec_hash[speech.specialization.name]}.png"
      image_tag image, :size => "20x20"
    end
  end
end