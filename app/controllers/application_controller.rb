class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def push_message(recipient_id)
    Pusher["messages"].trigger("new", { recipient_id: recipient_id })
  end
end
