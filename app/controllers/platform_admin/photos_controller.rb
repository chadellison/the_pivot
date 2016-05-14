class PlatformAdmin::PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def destroy
    photo = Photo.find(params[:id])
    photo.destroy
    flash["success"] = "#{photo.title} was successfully removed"
    redirect_to platform_admin_photos_path
  end
end
