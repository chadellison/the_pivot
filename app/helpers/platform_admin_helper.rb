module PlatformAdminHelper
  def most_popular_photos
    photo_ids = OrderPhoto.pluck(:photo_id)
    photo_ids.map { |id| Photo.find(id) }.group_by(&:title)
  end
end