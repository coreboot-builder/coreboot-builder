module ApplicationHelper
  def flash_messages(opts = {})
    flash.map do |msg_type, message|
      content_tag(:div, message, class: "flash-alert flash-alert-#{msg_type}", data: { dismiss: 'alert' }) do
        concat message
      end
    end.join.html_safe
  end
end
