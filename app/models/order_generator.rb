class OrderGenerator
  def initialize(user, cart)
    order = Order.new(user_id: user.id, total_cost: cart.total_price)
    create_order_photos(order, cart) if order.save
  end

  def create_order_photos(order, cart)
    cart.cart_photos.each_pair do |photo_id, vendor_id|
      order.order_photos.create(vendor_id: vendor_id.to_i,
                                order_id: order.id,
                                photo_id: photo_id.to_i,
                                cost: cart.find_cost(photo_id))
    end
  end
end
