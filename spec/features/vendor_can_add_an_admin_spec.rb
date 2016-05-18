require 'rails_helper'

RSpec.feature "Vendor can add an admin" do
  scenario "a vendor adds a new admin" do
    admin  = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "test@test.com")
    role   = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1", status: 1)
    UserRole.create(user: admin, vendor: vendor, role: role)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit("/dashboard/#{admin.id}")
    within(".side-menu") do
      click_on("Add Admin")
    end
    within(".create-admin-form") do
      fill_in "user[username]", with: "username"
      fill_in "user[email]", with: "e@mail.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_on "Create Admin"
    end

    vendor = Vendor.first
    expect(vendor.users.count).to eq(2)
    expect(vendor.users.last.roles.last.name).to eq("vendor_admin")
    expect(page).to have_content("Admin successfully created.")
  end

  scenario " a vendor adds an existing user as an admin" do
    admin  = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "test@test.com")
    user   = User.create(username: "user", password: "pass", password_confirmation: "pass", email: "email@email.com")
    role   = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1", status: 1)
    UserRole.create(user: admin, vendor: vendor, role: role)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit("/dashboard/#{admin.id}")
    within(".side-menu") do
      click_on("Add Admin")
    end
    within(".add-admin-form") do
      fill_in "user[username]", with: "user"
      click_on "Add Admin"
    end

    vendor = Vendor.first
    expect(vendor.users.count).to eq(2)
    expect(vendor.users.last.username).to eq("user")
    expect(vendor.users.last.roles.last.name).to eq("vendor_admin")
    expect(page).to have_content("Admin successfully created.")
  end
end
