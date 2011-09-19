# -*- encoding : utf-8 -*-
class AvatarsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @avatar = current_user.avatar
  end

  def create
    @avatar = current_user.build_avatar params[:avatar]
    if @avatar.save
      redirect_to user_avatar_path, :notice => "Avatar dodany prawidłowo"
    else
      render :action => 'index'
    end
  end

  def update_crop
    @avatar = current_user.avatar
    @avatar.crop_x = params[:avatar]["crop_x"]
    @avatar.crop_y = params[:avatar]["crop_y"]
    @avatar.crop_h = params[:avatar]["crop_h"]
    @avatar.crop_w = params[:avatar]["crop_w"]
    @avatar.save
    redirect_to user_avatar_path
  end

  def destroy
    @avatar = current_user.avatar
    if @avatar.remove_avatar_and_crops
      redirect_to user_avatar_path
    else
      render :action => 'index'
    end
  end
end

