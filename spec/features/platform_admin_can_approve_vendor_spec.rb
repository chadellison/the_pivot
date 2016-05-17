require "rails_helper"

RSpec.feature "platform admin can approve a vendor" do
  scenario "vendor's page is displayed on the site and acquires vendor status" do
    Role.create(name: "vendor_admin")
    admin = User.create(username: "Anna",
                        password: "123",
                        password_confirmation: "123",
                        email: "anna@gmail.com")
    admin.roles.create(name: "platform_admin")

    user = User.create(username: "Travis",
                       password: "123",
                       password_confirmation: "123",
                       email: "travis@gmail.com")

    user.roles.create(name: "customer")
    visit root_path

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path(user.id)
    click_on "Create Business"
    fill_in "Name", with: "Beautiful Photos"
    fill_in "About", with: "This business is about beautiful photos"
    click_on "Create Business"
    expect(page).to have_content "Request for business sent"
    expect(current_path).to eq dashboard_path(user.id)
    visit vendors_path
    expect(page).not_to have_content "Beautiful Photos"
    expect(User.find(user.id).roles.last.name).to eq "customer"


    ApplicationController.any_instance.stubs(:current_user).returns(admin)
    visit platform_admin_dashboard_path(admin.id)
    click_on "Pending Vendors"
    expect(page).to have_content "Beautiful Photos"
    expect(page).to have_button "Deny"
    click_on "Approve"

    expect(page).to have_content "Beautiful Photos has been approved"
    visit vendors_path
    expect(page).to have_content "Beautiful Photos"
    expect(Vendor.last.status).to eq "active"
    assert User.find(user.id).roles.pluck(:name).include?("vendor_admin")
  end

  scenario "non-registered users cannot create businesses" do
    visit new_vendor_path
    expect(page).to have_content "404"
  end
end
