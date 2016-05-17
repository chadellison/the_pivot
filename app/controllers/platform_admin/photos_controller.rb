class PlatformAdmin::PhotosController < ApplicationController
  def index
    @photos = Photo.all
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    photo = Photo.find(params[:id])
    vendor = Vendor.find(photo.vendor.id)
    vendor.photos.find(photo.id).update(photo_params)
    flash["success"] = "#{Photo.find(photo.id).title} has been updated."
    redirect_to platform_admin_photos_path
  end

  def destroy
    photo = Photo.find(params[:id])
    PhotoCategory.where(photo: photo).delete_all
    photo.delete
    flash["success"] = "#{photo.title} was successfully removed"
    redirect_to platform_admin_photos_path
  end

  private

    def photo_params
      params.require(:photo).permit(:title,
                                    :description,
                                    :price,
                                    :vendor_id,
                                    :image)
    end
end
