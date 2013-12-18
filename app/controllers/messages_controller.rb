class MessagesController < ApplicationController
  def index
    @messages = Message.find_all_by_recipient_id(current_user.id)
    render :index
  end

  def sent_index
    @messages = Message.find_all_by_sender_id(current_user.id)
    render :sent
  end

  def show
    @message = Message.find(params[:id])
    @sender = User.find(@message.sender_id)
    @recipient = User.find(@message.recipient_id)

    if is_current_user?(@message.recipient_id)
      @message.read = true
      @message.save
      render :show
    elsif is_current_user?(@message.sender_id)
      render :show
    else
      flash[:errors] = ["You are not authorized to view this message."]
      redirect_to new_session_url
    end
  end

  def new
    @message = Message.new
    @recipients = User.all
    render :new
  end

  def create
    params[:message][:sender_id] = current_user.id
    @message = Message.new(params[:message])
    if @message.save
      msg = NotificationMailer.message_received_email(@message)
      msg.deliver!
      flash[:notice] = ["Message sent!"]
      redirect_to new_message_url
    else
      flash[:errors] ||= []
      flash[:errors] += @message.errors.full_messages
      @recipients = User.all
      render :new
    end
  end

  def destroy
  end
end
