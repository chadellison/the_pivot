class PhotosController < ApplicationController

  def index
    @photos = Photo.all
  end

  # def show
  #   @photo = Photo.find(params[:id])
  # end
  #
  # def create
  #   @photo = Photo.new(photo_params)
  #
  #   if @photo.save
  #     flash[:success] = "Photo: #{@photo.title} Created"
  #     redirect_to photo_path(@photo)
  #   else
  #     flash[:alert] = @photo.errors.full_messages.join(", ")
  #     redirect_to admin_dashboard_path
  #   end
  #
  # end
  #
  # private
  #
  # def photo_params
  #   params.require(:photo).permit(:title, :description, :price, :destination_id, :image)
  # end

end
