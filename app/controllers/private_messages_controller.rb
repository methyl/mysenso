# -*- encoding : utf-8 -*-
class PrivateMessagesController < ApplicationController

  before_filter :authenticate_user!

  def index
    @received_messages = current_user.received_messages.order_by([:created_at, :desc]).limit(50)
    @sent_messages = current_user.sent_messages.limit(20)
  end

  def show
    @message = PrivateMessage.find(params[:id])
    @message.read! if @message.receiver == current_user
  end

  def new
    @message = PrivateMessage.new
  end

  def create
    @message = PrivateMessage.new params[:private_message]
    @message.sender = current_user
    if @message.save
      redirect_to user_path(@message.receiver), :notice => "Wiadomość została wysłana"
    else
      render :new
    end
  end

  def destroy_multiple
    messages = PrivateMessage.where(:_id.in => params[:private_message_ids])
    puts messages.count
    messages.each {|m| m.destroy if m.receiver == current_user}
    redirect_to private_messages_path
  end

end
