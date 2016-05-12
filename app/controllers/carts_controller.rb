class CartsController < ApplicationController

  def create
    photo = Photo.find(params[:photo_id])
    @cart.add_package(photo.id)
    session[:cart] = @cart.cart_photos
    redirect_to package_path(photo)
  end

   def show
    @packages = @cart.find_packages if @cart.cart_photos
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
