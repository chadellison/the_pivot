class CartsController < ApplicationController

  def create
    find_referrer
    photo = Photo.find(params[:photo_id])
    @cart.add_photo(photo.id)
    session[:cart] = @cart.cart_photos
    flash[:success] = "Successfully added photo to cart."
    redirect_to session.delete(:return_to)
  end

  def show
    @photos = @cart.find_photos if @cart.cart_photos
  end

  def destroy
    photo = Photo.find(params[:photo])
    @cart.cart_photos.delete(params[:photo])
    redirect_to "/cart"
  end

end
