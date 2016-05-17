require 'rails_helper'

RSpec.feature "Vendor can login" do
  scenario "vendor opens their dashboard" do
    visit login_path
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1")
    vendor2 = Vendor.create(name: "Vendor2")
    UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)
    UserRole.create(user_id: user.id, vendor_id: vendor2.id, role_id: role.id)

    visit("/")
    click_on("Login")
    fill_in("session[username]", with: "test")
    fill_in("session[password]", with: "pass")
    click_on("Sign In")

    expect(current_path).to eq dashboard_path(user.id)
    expect(page).to have_content("Vendor1")
    expect(page).to have_content("Vendor2")
  end

  scenario "registered user opens their dashboard" do
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    user.roles.create(name: "customer")
    vendor = Vendor.create(name: "Vendor1")
    vendor2 = Vendor.create(name: "Vendor2")

    visit("/")
    click_on("Login")
    fill_in("session[username]", with: "test")
    fill_in("session[password]", with: "pass")
    click_on("Sign In")

    visit dashboard_path(user)

    within(".dashboard") do
      expect(current_path).to eq dashboard_path(user.id)
      expect(page).not_to have_content(vendor.name)
      expect(page).not_to have_content(vendor2.name)
    end
  end
end
