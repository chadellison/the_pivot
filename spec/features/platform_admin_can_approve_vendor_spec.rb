require "rails_helper"

RSpec.feature "platform admin can approve a vendor" do
  scenario "vendor's page is displayed on the site and acquires vendor status" do
    admin = User.create(username: "Anna",
                        password: "123",
                        password_confirmation: "123",
                        email: "anna@gmail.com")
    admin.roles.create(name: "platform_admin")

    user = User.create(username: "Travis",
                       password: "123",
                       password_confirmation: "123",
                       email: "travis@gmail.com")
    visit root_path

    visit vendors_path
    click_on "Login"
    fill_in "Username", with: "Travis"
    fill_in "Password", with: "123"
    click_on "Sign In"

    expect(current_path).to eq dashboard_path(user.id)

    click_on "Create Business"
    expect(current_path).to eq new_vendor_path
    fill_in "Name", with: "Beautiful Photos"
    fill_in "About", with: "This business is about beautiful photos"
    click_on "Create Business"

    expect(page).to have_content "Request for business sent"
    expect(current_path).to eq dashboard_path(user.id)

    visit vendors_path
    expect(page).not_to have_content "Beautiful Photos"
    expect(User.find(user.id).roles).to eq ["customer"]
    click_on "Logout"

    click_on "Login"
    fill_in "Username", with: "Anna"
    fill_in "Password", with: "123"
    click_on "Sign In"

    click_button "Pending Vendors"
    expect(page).to have_button "Deny"
    click_on "Approve"
    expect(page).to have_content "Beautiful Photos has been approved"
    visit vendors_path
    expect(page).to have_content "Beautiful Photos"
    expect(Vendor.last.status).to eq "active"
    expect(User.find(user.id).roles).to eq ["customer", "vendor_admin"]
  end
end
