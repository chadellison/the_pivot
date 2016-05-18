class DownloadsController < ApplicationController
  def show
    photo = Photo.find(params[:photo])
    data = open(photo.image.url)
    send_data data.read, :type => data.content_type, :x_sendfile => true
  end
end
