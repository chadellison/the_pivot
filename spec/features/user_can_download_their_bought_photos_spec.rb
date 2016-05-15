require 'rails_helper'

RSpec.feature "User can download their bought photos" do
  scenario "when already purchased a user can click download on orders index" do
    role = Role.create(name: "customer")
    user = User.new(id: 1)
    user.save(validate: false)
    UserRole.create(user_id: user.id, role_id: role.id)
    vendor1 = Vendor.create(name: "vendor1", status: "Active")
    photo = vendor1.photos.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description")
    order = Order.create(user_id: 1, total_cost: 20)
    order_photo1 = OrderPhoto.create(order_id: order.id, photo_id: photo.id, vendor_id: vendor1.id)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit order_path(order)


    within ".orders" do
      expect(page).to have_link "Download", href: download_path(photo: photo)
    end


  end
end
