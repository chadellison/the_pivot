require 'rails_helper'

RSpec.feature "Vendor can take their store offline" do
  scenario "vendor takes their store offline" do
    category = Category.create(name: "new category")
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1")
    vendor.update(status: "Active")
    UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit("/dashboard/#{user.id}")
    within(".dashboard") do
      click_on "Vendor1"
    end
    within("#vendor1-form") do
      click_on "Take Store Offline"
    end

    vendor = Vendor.find_by(name: "Vendor1")
    expect(current_path).to eq(dashboard_path(user.id))
    expect(page).to have_content("Store Successfully Taken Offline")
    expect(page).to have_content("Vendor1")
    expect(vendor.status).to eq("Inactive")
  end
end
