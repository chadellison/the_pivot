require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:photos) }
  it { should have_many(:order_photos) }

  it "can retrieve total_quantity" do
    photo = Photo.new(id: 1)
    photo.save(validate: false)

    order = Order.new(id: 1)
    order.save(validate: false)

    order_photo1 = OrderPhoto.new(order_id: 1, photo_id: 1)
    order_photo2 = OrderPhoto.new(order_id: 1, photo_id: 1)
    order_photo1.save(validate: false)
    order_photo2.save(validate: false)

    expect(order.total_quantity).to eq 2
  end

  it "can retrieve photo_names" do
    photo = Photo.new(id: 1, title: "Mars")
    photo.save(validate: false)

    order = Order.new(id: 1)
    order.save(validate: false)

    order_photo = OrderPhoto.new(order_id: 1, photo_id: 1)
    order_photo.save(validate: false)

    expect(order.photo_names).to eq "Mars"
  end

  it "can calculate subtotal" do
    photo1 = Photo.new(id: 1, price: 2000)
    photo1.save(validate: false)

    order = Order.new(id: 1)
    order.save(validate: false)

    expect(order.subtotal(photo1)).to eq 2000.0

  end

  it "can create order photos" do
    vendor = Vendor.new(id: 1, name: "vendor")
    vendor.save(validate: false)
    photo = Photo.create(id: 1, price: 1000,
                             title: "Basic1",
                             description: "Basic photo.",
                             vendor_id: 1)

    photo1 = Photo.create(id: 2,
                              price: 2000,
                              title: "Basic2",
                              description: "Basic photo1.",
                              vendor_id: 1)


    user = User.new(id: 1)

    user.save(validate: false)
    cart = Cart.new({ "1" => "1", "2" => "1" })

    OrderGenerator.new(user, cart)

    expect(OrderPhoto.count).to eq(2)
  end
end
