require "rails_helper"

RSpec.feature "Platform admin can edit vendors" do
  scenario "Platform admin and vendor see vendor's updated status" do
    user = User.create(username: "Jones", password: "password", password_confirmation: "password", email: "jones@gmail.com")
    user.roles.create(name: "platform_admin")

    vendor = Vendor.create(name: "Jojo blu")

    visit root_path
    click_on "Login"
    fill_in "Username", with: "Jones"
    fill_in "Password", with: "password"
    click_on "Sign In"

    visit vendors_path

    within(".vendor") do
      expect(page).not_to have_content "Jojo blu"
    end

    visit dashboard_path(user.id)
    click_on "All Vendors"
    expect(current_path).to eq platform_admin_vendors_path
    expect(page).to have_content "Jojo blu"

    expect(page).to have_content "Status: Inactive"
    click_on "Edit"
    fill_in "Status", with: "Active"
    click_on "Update Vendor"

    expect(page).to have_content "Jojo blu has been updated."
    expect(current_path).to eq platform_admin_vendors_path
    expect(page).to have_content "Status: Active"

    visit vendors_path
    expect(page).to have_content "Jojo blu"
  end

  scenario "non-platform admins cannot access all vendors" do
    user = User.create(username: "Rosco", password: "password", password_confirmation: "password", email: "rosco@gmail.com")
    user.roles.create(name: "vendor_admin")

    visit root_path
    click_on "Login"
    fill_in "Username", with: "Rosco"
    fill_in "Password", with: "password"
    click_on "Sign In"

    visit platform_admin_vendors_path
    expect(page).to have_content "404"
  end
end
