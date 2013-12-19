class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def push_message
    Pusher["messages"].trigger("new", { msg: "new message" })
  end
end
