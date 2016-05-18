require 'rails_helper'

RSpec.feature "Vendor can edit their store" do
  scenario "vendor edits their store" do
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1")
    vendor.update(status: 1)
    UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit("/dashboard/#{user.id}")
    within(".side-menu") do
      click_on "Vendor1"
    end
    fill_in "vendor[name]", with: "New Vendor Name"
    fill_in "vendor[about]", with: "New Vendor Description"
    click_on "Update Vendor"

    expect(current_path).to eq(dashboard_path(user.id))
    expect(page).to have_content("Vendor Information Updated")
    expect(page).to have_content("New Vendor Name")
  end

  scenario 'vendor cannot edit another vendor store' do
    user     = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role     = Role.create(name: "vendor_admin")
    vendor1  = Vendor.create(name: "Vendor1")
    vendor2  = Vendor.create(name: "Vendor2")
    UserRole.create(user_id: user.id, vendor_id: vendor1.id, role_id: role.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit("/dashboard/#{user.id}")

    within(".side-menu") do
      expect(page).not_to have_content("Vendor2")
    end
  end

  scenario 'vendor cannot edit their store with bad params' do
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1")
    vendor.update(status: 1)
    UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit("/dashboard/#{user.id}")
    within(".side-menu") do
      click_on "Vendor1"
    end
    fill_in "vendor[name]", with: ""
    fill_in "vendor[about]", with: "New Vendor Description"
    click_on "Update Vendor"

    expect(current_path).to eq("/vendor_admin/vendors/#{vendor.id}")
    expect(page).to have_content("Please try again.")
    expect(page).to have_content("Vendor1")
  end
end
