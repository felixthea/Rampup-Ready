module MessagesHelper

  def unread_messages
    sum_new_messages = Message.find_all_by_recipient_id_and_read(current_user.id,false).count
    if sum_new_messages > 0
      return " (" + sum_new_messages.to_s + ")"
    else
      return ""
    end
  end

end
