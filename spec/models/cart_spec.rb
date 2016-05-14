require "rails_helper"

RSpec.describe Cart, type: :model do
  it "user can add photo to cart(cart) and associate proper vendor" do
    vendor1 = Vendor.new(id: 1, name: "vendor")
    vendor1.save(validate: false)
    vendor2 = Vendor.new(id: 2, name: "vendor")
    vendor2.save(validate: false)
    photo1 = Photo.create(id: 1, price: 1000, title: "Basic1", description: "Basic photo1.", vendor_id: 1)
    photo2 = Photo.create(id: 2, price: 2000, title: "Basic2", description: "Basic photo2.", vendor_id: 2)

    cart = Cart.new({ "1" => "1" })

    cart.add_photo(2)

    expect(cart.cart_photos).to eq({ "1" => "1", "2" => "2" })
  end

  it "can sum the prices in the cart(cart)" do
    vendor1 = Vendor.new(id: 1, name: "vendor")
    vendor1.save(validate: false)
    vendor2 = Vendor.new(id: 2, name: "vendor")
    vendor2.save(validate: false)
    photo1 = Photo.create(id: 1, price: 1000, title: "Basic1", description: "Basic photo1.", vendor_id: 1)
    photo2 = Photo.create(id: 2, price: 2000, title: "Basic2", description: "Basic photo2.", vendor_id: 2)
    cart = Cart.new({ "1" => "1", "2" => "2" })

   expect(cart.total_price).to eq(3000)
  end

  it "can get total quantity of photos" do
    cart = Cart.new({ "1" => "1", "2" => "1" })

    expect(cart.quantity).to eq 2
  end





end
