class CartsController < ApplicationController

  def create
    photo = Photo.find(params[:photo_id])
    @cart.add_photo(photo.id)
    session[:cart] = @cart.cart_photos
    redirect_to vendor_path(photo.vendor.slug)
  end

   def show
    @photos = @cart.find_photos if @cart.cart_photos
  end

  def update
    @cart.adjust_quantity(params[:operation], params[:id])
    redirect_to '/cart'
  end


  def destroy
    photo = Photo.find(params[:id])
    @cart.cart_photos.delete(params[:id])
    redirect_to "/cart"
  end

end
