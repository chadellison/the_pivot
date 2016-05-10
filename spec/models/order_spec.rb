require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:packages) }
  it { should have_many(:order_packages) }

  it "can retrieve the package sub quantity" do

    package = Package.new(id: 1)
    package.save(validate: false)

    order = Order.new(id: 1)
    order.save(validate: false)

    order_package1 = OrderPackage.new(order_id: 1, package_id: 1)
    order_package2 = OrderPackage.new(order_id: 1, package_id: 1)
    order_package3 = OrderPackage.new(order_id: 1, package_id: 1)
    order_package1.save(validate: false)
    order_package2.save(validate: false)
    order_package3.save(validate: false)

    expect(order.package_quantity(1)).to eq 3
  end

  it "can retrieve total_quantity" do
    package = Package.new(id: 1)
    package.save(validate: false)

    order = Order.new(id: 1)
    order.save(validate: false)

    order_package1 = OrderPackage.new(order_id: 1, package_id: 1)
    order_package2 = OrderPackage.new(order_id: 1, package_id: 1)
    order_package1.save(validate: false)
    order_package2.save(validate: false)

    expect(order.total_quantity).to eq 2
  end

  it "can retrieve package_names" do
    package = Package.new(id: 1, title: "Mars")
    package.save(validate: false)

    order = Order.new(id: 1)
    order.save(validate: false)

    order_package = OrderPackage.new(order_id: 1, package_id: 1)
    order_package.save(validate: false)

    expect(order.package_names).to eq "Mars"
  end

  it "can calculate subtotal" do
    package1 = Package.new(id: 1, price: 2000)
    package1.save(validate: false)

    package2 = Package.new(id: 2, price: 2000)
    package2.save(validate: false)

    order = Order.new(id: 1)
    order.save(validate: false)

    order_package1 = OrderPackage.new(order_id: 1, package_id: 1)
    order_package1.save(validate: false)
    order_package2 = OrderPackage.new(order_id: 1, package_id: 1)
    order_package2.save(validate: false)
    order_package3 = OrderPackage.new(order_id: 1, package_id: 2)
    order_package3.save(validate: false)

    expect(order.subtotal(package1)).to eq 4000.0
    expect(order.subtotal(package2)).to eq 2000.0
  end

  it "can create order packages" do
    package = Package.create(id: 1, price: 1000,
                             title: "Basic1",
                             description: "Basic package.")
    package1 = Package.create(id: 2,
                              price: 2000,
                              title: "Basic2",
                              description: "Basic package1.")
    order = Order.new(id: 1)
    order.save(validate: false)
    trip = Trip.new({ "1" => 1, "2" => 2 })
    user = User.new(id: 1)
    user.save(validate: false)

    OrderGenerator.new(user, trip)

    expect(Order.last.packages.count).to eq(3)
  end
end
