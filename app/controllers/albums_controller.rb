class AlbumsController < ApplicationController
  def index
    @user = User.find params[:user_id]
    @albums = @user.albums.page(params[:page]).per(6)
  end
  
  def manage
    @albums = current_user.albums.page(params[:page]).per(6)
  end
  
  def manage_photos
    @album = Album.find params[:id]
    @photos = @album.photos.page(params[:page]).per(6)
  end
  
  def new
    @album = current_user.albums.build
  end
end
