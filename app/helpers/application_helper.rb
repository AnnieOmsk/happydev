# encoding: utf-8

module ApplicationHelper
  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
     type = :success if type == :notice
     type = :error   if type == :alert
     text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
     flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def error_messages_for name, resource
    resource.errors[name][0].mb_chars.capitalize.to_s rescue nil if resource.errors[name] && resource.errors[name][0]
  end
end
