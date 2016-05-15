class DownloadsController < ApplicationController
  def show
    photo = Photo.find(params[:photo])
    send_file photo.image.path, type: "image/jpeg"
  end
end
