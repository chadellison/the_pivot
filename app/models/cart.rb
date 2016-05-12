class Cart
  attr_reader :cart_photos

  def initialize(initial_cart)
    @cart_photos = initial_cart || {}
  end

  def add_photo(photo_id)
    cart_photos[photo_id.to_s] ||= 0
    cart_photos[photo_id.to_s] += 1
  end

  def total_price
    cart_photos.map do |id, quantity|
      Photo.find(id).price * quantity
    end.sum
  end

  def find_photos
    cart_photos.keys.map do |id|
      Photo.find(id)
    end
  end

  def subtotal(photo)
    photo.price * sub_quantity(photo.id)
  end

  def quantity
    cart_photos.values.sum
  end

  def sub_quantity(id)
    cart_photos.values_at(id.to_s).sum
  end

  def adjust_quantity(operation, id)
    if operation == "+"
      cart_photos[id] += 1
    else
      cart_photos[id] -= 1
    end
  end

  def stripe_price
    total_price.to_i * 100
  end

end
