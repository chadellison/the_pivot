require "rails_helper"

RSpec.feature "Platform admin can remove a vendor" do
  scenario "vendor is no longer displayed on" do
    role = Role.create(name: "platform_admin")
    user = User.create(username: "Jones", password: "password", password_confirmation: "password", email: "jones@gmail.com")
    user.roles << role

    vendor = Vendor.create(name: "Jojo blu", status: "active")
    photo = Photo.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description", vendor_id: vendor.id)
    photo.categories.create(name: "food")
    vendor.photos << photo

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit platform_admin_dashboard_path

    click_link "Active Vendors"
    expect(current_path).to eq platform_admin_dashboard_path
    expect(page).to have_content "Jojo blu"

    click_on "All Vendors"

    click_button "Take Offline"
    expect(page).to have_content "Jojo blu has been taken offline"
    expect(Vendor.active).to eq []

    visit root_path
  end

  scenario "non-admins cannot remove vendors" do
    user = User.create(username: "Rosco", password: "password", password_confirmation: "password", email: "jones@gmail.com")
    reg_user = Role.create(name: "customer")

    vendor = Role.create(name: "vendor_admin")

    visit platform_admin_dashboard_path
    expect(page).to have_content "404"

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    user.roles << reg_user

    visit platform_admin_dashboard_path
    expect(page).to have_content "404"

    user.roles << vendor

    visit platform_admin_dashboard_path
    expect(page).to have_content "404"
  end
end
