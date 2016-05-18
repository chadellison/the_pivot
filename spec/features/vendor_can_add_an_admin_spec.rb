require 'rails_helper'

RSpec.feature "Vendor can add an admin" do
  scenario "a vendor adds a new admin" do
    # As a Vendor Admin
    admin  = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "test@test.com")
    role   = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1", status: 1)
    UserRole.create(user: admin, vendor: vendor, role: role)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    # When I visit my dashboard
    visit("/dashboard/#{admin.id}")
    # and click on Add Admin
    click_on("Add Admin")
    # And fill in the form  fields for the account information of a new admin
    save_and_open_page
    within(".vendor-admin-form") do
      fill_in "user[username]", with: "username"
      fill_in "user[email]", with: "e@mail.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
    end
    # And I click on "Create Admin"
    click_on "Create Admin"

    # I expect to see a confirmation page stating the admin was created.
    vendor = Vendor.first
    expect(page).to have_content("Admin successfully created")
    # And I expect for a new admin associated with my store to have been created.
    expect(vendor.users.count).to eq(2)
    expect(vendor.users.last).to eq(user)
  end

  scenario " a vendor adds an existing user as an admin" do
    # As a Vendor Admin
    admin  = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "test@test.com")
    user   = User.create(username: "user", password: "pass", password_confirmation: "pass", email: "email@email.com")
    role   = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1", status: 1)
    UserRole.create(user: admin, vendor: vendor, role: role)
    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    # When I visit my dashboard
    visit("/dashboard/#{admin.id}")
    # and click on Add Admin
    click_on("Add Admin")
    # And fill in a form with an existing user name
    fill_in "vendor_user[name]", with: "New Admin Name"
    # And I click on "Add Admin"
    click_on "Add Admin"

    # I expect to see a confirmation page stating the admin was created.
    expect(page).to have_content("Admin successfully created")
    # And I expect for a new admin associated with my store to have been created.
    vendor = Vendor.first
    expect(vendor.users.count).to eq(2)
    expect(vendor.users.last).to eq(user)
  end
end
