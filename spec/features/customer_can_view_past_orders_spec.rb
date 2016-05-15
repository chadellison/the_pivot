require 'rails_helper'

RSpec.feature "Customer can view past orders" do
  scenario "user visits their dashboard and clicks 'Order History'" do
    role = Role.create(name: "customer")
    user = User.new(id: 1, username: "John Doe")
    user.save(validate: false)
    UserRole.create(user_id: user.id, role_id: role.id)
    vendor = Vendor.create(name: "vendor1", status: "Active")
    photo = vendor.photos.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"),
                                 price: 20, description: "description")
    order = Order.create(user_id: 1, total_cost: 20)
    order_photo = OrderPhoto.create(order_id: order.id, photo_id: photo.id, vendor_id: vendor.id)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit dashboard_path(user.id)

    expect(current_path).to eq("/dashboard/#{user.id}")

    click_on "Order History"
    expect(current_path).to eq("/orders/#{order.id}")
    expect(page).to have_content("photo") #photo title
    expect(page).to have_content("20.00") #photo price
    expect(page).to have_content("Total price for this order: 20.00") #total price
    expect(page).to have_xpath("//img[@src=\"#{photo.image}\"]")
  end
end
