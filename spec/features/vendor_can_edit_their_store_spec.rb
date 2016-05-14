require 'rails_helper'

RSpec.feature "Vendor can edit their store" do
  scenario "vendor edits their store" do
    category = Category.create(name: "new category")
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1")
    UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)

    visit login_path
    fill_in "Username", with: "test"
    fill_in "Password", with: "pass"
    click_button "Sign In"
    expect(current_path).to eq("/dashboard/#{user.id}")
    within(".dashboard") do
      click_on "Vendor1"
    end
    expect(current_path).to eq("/vendor_admin/vendors/#{vendor.id}")

    fill_in "vendor[name]", with: "New Vendor Name"
    fill_in "vendor[about]", with: "New Vendor Description"
    click_on "Update Vendor"

    expect(current_path).to eq(dashboard_path(user.id))
    expect(page).to have_content("Vendor Information Updated")
    expect(page).to have_content("New Vendor Name")
  end
end
