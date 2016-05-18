class PhotosController < ApplicationController

  def index
    @photos = Photo.all
    @categories = Category.all
    @slide_photos = Photo.limit(5)
  end

  def create
    params_parser = UploadPhotoParser.new(params)
    @photo = params_parser.vendor.photos.new(params_parser.photo_info)

    if @photo.save
      @photo.categories << params_parser.category
      render json: { message: "success" }, :status => 200
    else
      render json: { error: "Failed - Please Enter Valid Info" }, :status => 400
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :price, :image, :vendor_id)
  end

end
