require 'rails_helper'

RSpec.feature "Registered user can checkout and see the order they placed" do
  scenario "when they checkout through their cart they see their order placed" do
    role = Role.create(name: "customer")
    user = User.new(id: 1)
    user.save(validate: false)
    UserRole.create(user_id: user.id, role_id: role.id)
    vendor1 = Vendor.create(name: "vendor1", status: "active")
    photo1 = vendor1.photos.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description")

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit '/vendor1'

    click_on "Purchase"

    visit '/cart'

    click_on "Checkout"

    expect(current_path).to eq "/orders"


    within ".orders" do
      expect(page).to have_content "1"
      expect(page).to have_content "$20"
      expect(page).to have_content "photo"
      expect(page).to have_content "vendor1"
    end

  end
end
