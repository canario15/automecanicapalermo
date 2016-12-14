module ApplicationHelper

  def errors_for(model, attribute)
    if model.errors[attribute].present?
      content_tag :span, :class => 'error_explanation' do
        model.errors[attribute].join(", ")
      end
    end
  end

  def flash_notifications
    message = flash[:alert] || flash[:notice]
    if message
      type = flash.keys[0].to_s
      if type == 'alert'
        "<p id='have_alert' data-type='error'>#{flash[:alert]}</p>".html_safe
      else
        if type == 'notice'
          "<p id='have_alert' data-type='success'>#{flash[:notice]}</p>".html_safe
        end
      end
    end
  end

end
