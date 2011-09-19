# -*- encoding : utf-8 -*-
class ReferencesController < ApplicationController
  before_filter :authenticate_user!  

  def index
    @references = current_user.references
  end

  def new
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.find(params[:user_id])
    @reference = @user.references.build(params[:reference])
    @reference.issuer = current_user
    if @reference.save
      redirect_to user_path(@user), :notice => "Referencja została wystawiona, zaczekaj na akceptację użytkownika"
    else
      render :action => :new
    end
  end

  def accept
    @reference = Reference.find(params[:id])
    if @reference.update_attributes(:accepted => true)
      redirect_to references_path, :notice => "Referencja została zaakceptowana, znajdziesz ją w swoim profilu" and return
    else
      redirect_to references_path, :error => "Wystąpił błąd podczas akceptacji referencji, spróbuj ponownie później"
    end
  end

end
