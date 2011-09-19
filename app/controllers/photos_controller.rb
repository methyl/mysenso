class PhotosController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  def manage
    @photos = current_user.photos
    @photo = Photo.new 
  end

  def create
    @photos = current_user.photos
    @photo = current_user.photos.build(params[:photo])
    (redirect_to manage_photos_path, :alert => "Limit zdjęć został przekroczony" if current_user.photos_limit_exceeded?) and return
    if @photo.save
      redirect_to manage_photos_path, :notice => "Zdjęcie dodane prawidłowo"
    else
      render :action => :manage
    end

  end

  def show
    @photo = Photo.find(params[:id])
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.update_attributes(params[:photo])
      redirect_to photo_path(@photo), :notice => "Zdjęcie edytowane prawidłowo"
    else
      render :action => :edit
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.destroy
      redirect_to manage_photos_path, :notice => "Zdjęcie zostało usunięte"
    else
      redirect_to manage_photos_path, :alert => "Zdjęcie nie zostało usunięte"
    end
  end
end
