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

  def root_path_with_anchor(anchor)
    if controller.controller_name == 'home' && controller.action_name == 'index'
      '#' + anchor
    else
      root_path(:anchor => anchor)
    end
  end

  def title(page_title)
    content_for(:title) { page_title + " | HappyDev'12" }
  end

  def social_links_only_main
    if controller.controller_name == 'home' && controller.action_name == 'index'
      "set_class_for_footer"
    end
  end
end
