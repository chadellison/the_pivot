class Cart
  attr_reader :cart_photos

  def initialize(initial_cart)
    @cart_photos = initial_cart || {}
  end

  def add_photo(photo_id)
    cart_photos[photo_id.to_s] ||= 0
    cart_photos[photo_id.to_s] = (find_vendor_id(photo_id)).to_s
  end

  def total_price
    find_photos.reduce(0) do |sum, photo|
      sum += photo.price
    end
  end

  def find_vendor_id(photo_id)
    photo = Photo.find(photo_id).vendor_id
  end

  def find_photos
    cart_photos.keys.map do |id|
      Photo.find(id)
    end
  end

  def find_cost(photo_id)
    Photo.find(photo_id).price
  end

  def quantity
    cart_photos.keys.count
  end

end
