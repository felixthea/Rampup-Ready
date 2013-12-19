class InboundController < ApplicationController
  include MessagesHelper

  def notify_recipient
    recipient = User.find(params[:recipient_id])

    if current_user == recipient
      render :json => { current_user: "true", message_count: unread_messages}
    else
      render :json => { current_user: "false" }
    end
  end
end