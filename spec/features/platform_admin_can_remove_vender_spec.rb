require "rails_helper"

RSpec.feature "Platform admin can remove a vendor" do
  scenario "vendor is no longer displayed on" do
    role = Role.create(name: "platform_admin")
    user = User.create(username: "Jones", password: "password", password_confirmation: "password", email: "jones@gmail.com")
    user.roles << role

    vendor = Vendor.create(name: "Jojo blu", status: "active")
    photo = Photo.create(title: "photo", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")

    vendor.photos << photo

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit platform_admin_dashboard_path(user.id)


    click_link "Edit Vendors"
    expect(current_path).to eq platform_admin_vendors_path
    expect(page).to have_content "Jojo blu"

    click_on "All Vendors"

    click_button "Delete"
    expect(page).to have_content "Jojo blu was successfully removed!"
    expect(Vendor.all).to eq []

    visit root_path
  end

  scenario "non-admins cannot remove vendors" do
    user = User.create(username: "Rosco", password: "password", password_confirmation: "password", email: "jones@gmail.com")
    reg_user = Role.create(name: "customer")

    vendor = Role.create(name: "vendor_admin")

    visit platform_admin_vendors_path
    expect(page).to have_content "404"

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    user.roles << reg_user


    visit platform_admin_vendors_path
    expect(page).to have_content "404"

    user.roles << vendor

    visit platform_admin_vendors_path
    expect(page).to have_content "404"
  end
end
