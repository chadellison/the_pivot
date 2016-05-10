class OrderGenerator

  def initialize(user, trip)
    order = Order.new(user_id: user.id, total_cost: trip.total_price, status: 1)
    create_order_packages(order, trip) if order.save
  end

  def create_order_packages(order, trip)
    trip.itinerary.each_pair do |key, value|
      value.times do
        order.order_packages.create(user_id: order.user_id,
                              order_id: order.id,
                              package_id: key.to_i)
      end
    end
  end

end
