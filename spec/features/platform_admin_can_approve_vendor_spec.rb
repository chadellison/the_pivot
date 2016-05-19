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

    expect(user.roles).to eq []

    visit root_path

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path(user.id)
    within(".side-menu") do
      click_on "Become a Vendor"
    end
    fill_in "Name", with: "Beautiful Photos"
    fill_in "About", with: "This business is about beautiful photos"
    click_on "Create Business"
    expect(page).to have_content "Request for business sent"
    expect(current_path).to eq dashboard_path(user.id)
    visit vendors_path
    expect(page).not_to have_content "Beautiful Photos"
    expect(User.find(user.id).roles.last.name).to eq "vendor_admin"
    expect(User.find(user.id).vendors.last.status).to eq "pending"


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
    expect(User.find(user.id).roles.last.name).to eq "vendor_admin"

    expect(User.find(user.id).roles.count).to eq 1
  end

  scenario "User does not have more than one role of the same type" do
    Role.create(name: "vendor_admin")

    user = User.create(username: "Travis",
                       password: "123",
                       password_confirmation: "123",
                       email: "travis@gmail.com")

    expect(user.roles).to eq []

    visit root_path

    ApplicationController.any_instance.stubs(:current_user).returns(user)
    visit dashboard_path(user.id)
    click_on "Create Business"
    fill_in "Name", with: "Beautiful Photos"
    fill_in "About", with: "This business is about beautiful photos"
    click_on "Create Business"

    expect(User.find(user.id).roles.last).to eq Role.find_by(name: "vendor_admin")
    expect(Role.count).to eq 1

    within(".side-menu") do
      click_on "Create Business"
    end
    within(".create-business-form") do
      fill_in "Name", with: "hipster Photos"
      fill_in "About", with: "This business is about hipsters photos"
      click_on "Create Business"
    end

    expect(User.find(user.id).roles.last).to eq Role.find_by(name: "vendor_admin")
    expect(Role.count).to eq 1
  end

  scenario "non-registered users cannot create businesses" do
    visit new_vendor_path
    expect(page).to have_content "404"
  end
end
