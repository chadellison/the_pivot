require 'rails_helper'

RSpec.feature "User can view individual order" do
  scenario "when a user click view on orders index they see details of that order" do
    role = Role.create(name: "customer")
    user = User.new(id: 1)
    user.save(validate: false)
    UserRole.create(user_id: user.id, role_id: role.id)
    vendor = Vendor.create(name: "vendor1", status: "Active")
    photo = vendor.photos.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"),
                                 price: 20, description: "description")
    order = Order.create(user_id: 1, total_cost: 20)
    order_photo = OrderPhoto.create(order_id: order.id, photo_id: photo.id, vendor_id: vendor.id)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit orders_path

    click_on "View Order"

    expect(page).to have_link "photo", href: photo_path(photo)
    expect(page).to have_xpath("//img[@src=\"#{photo.image}\"]")
    expect(page).to have_content "$20"
    expect(page).to have_link "vendor1", href: vendor_path("vendor1")
    expect(page).to have_link "Download"

  end
end
