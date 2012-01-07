# -*- encoding : utf-8 -*-
class PrivateMessagesController < ApplicationController

  before_filter :authenticate_user!
  
  def index
    per_page = 5
    if params[:type] == :sent
      @messages = current_user.sent_messages.order_by([:created_at, :desc]).page(params[:page]).per(per_page)
    else
      @messages = current_user.received_messages.order_by([:created_at, :desc]).page(params[:page]).per(per_page)
    end
  end

  def show
    @message = PrivateMessage.find(params[:id])
    @message.read! if @message.receiver == current_user
    @reply = PrivateMessage.new 
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
    unless params[:private_message_ids].nil?
      messages = PrivateMessage.where(:_id.in => params[:private_message_ids])
      messages.each {|m| m.destroy if m.receiver == current_user}
    end
    redirect_to private_messages_path
  end
  
  def mark_as_read_multiple
    unless params[:private_message_ids].nil?
      messages = PrivateMessage.where(:_id.in => params[:private_message_ids])
      messages.each {|m| m.read! if m.receiver == current_user}
    end
    redirect_to private_messages_path
  end
  
  def destroy
    @message = PrivateMessage.find(params[:id])
    if @message.receiver == current_user and @message.destroy
      redirect_to private_messages_path, :notice => "Wiadomość została usunięta"
    else
      redirect_to private_messages_path, :error => "Wiadomość nie została usunięta"
    end
  end

end
