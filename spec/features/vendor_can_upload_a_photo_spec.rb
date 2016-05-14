require 'rails_helper'

RSpec.feature "Vendor can upload a photo" do
  scenario "vendor uploads their photo" do
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

    fill_in "Photo Title", with: "Super Lux"
    fill_in "Photo Description", with: "very lux"
    fill_in "Choose a Price for the New Photo", with: 1000.00
    find("option[value='#{category.id}']").click
    click_on "Create Photo"

    expect(current_path).to eq(dashboard_path(user.id))
    expect(page).to have_content("Photo: Super Lux Created")
  end
end
