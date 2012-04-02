# encoding: UTF-8

module ApplicationHelper
  include Haml::Helpers

  def logged_in?
    true if current_user
  end

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end

  def partial(template, *args)
    template_array = template.to_s.split('/')
    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"

    options = args.last.is_a?(Hash) ? args.pop : {}
    options.merge!(:layout => false)

    haml(template.to_sym, options)
  end

  BOOTSTRAP_FLASH_CLASS = {
    alert:   'warning',
    notice:  'info',
  }

  def bootstrap_flash_class(type)
    BOOTSTRAP_FLASH_CLASS[type] || type.to_s
  end

  def flash_messages
    flash.send(:values).each do |type, message|
      flash_message(type, message) if message.is_a?(String)
    end
  end

  def flash_message(type, message)
    haml_tag :div, class: "alert alert-#{bootstrap_flash_class(type)} fade in" do
      haml_tag 'a.close', '×', data: {dismiss: 'alert'}
      haml_concat(message)
    end
  end

  def block_message(type, main_message, messages = [])
    haml_tag :div, class: "alert alert-block alert-#{bootstrap_flash_class(type)} fade in" do
      haml_tag 'a.close', '×', data: {dismiss: 'alert'}
      haml_tag :h4,  main_message, class: 'alert-heading'
      haml_tag :ul do
        messages.each do |message|
          haml_tag :li, message
        end
      end
    end
  end
end
