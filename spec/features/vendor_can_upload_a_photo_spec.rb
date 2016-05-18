require 'rails_helper'

RSpec.feature "Vendor can upload a photo" do
  scenario "vendor uploads their photo" do
    category = Category.create(name: "new category")
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1")
    UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit("/dashboard/#{user.id}")
    within(".side-menu") do
      click_on "Vendor1"
    end
    within("#vendor1-form") do
      fill_in "Photo Title", with: "Super Lux"
      fill_in "Photo Description", with: "very lux"
      fill_in "photo[price]", with: 1000.00
      find("option[value='#{category.id}']").click
      click_on "Create Photo"
    end

    expect(current_path).to eq(dashboard_path(user.id))
    expect(page).to have_content("Photo: Super Lux Created")
  end

  scenario "vendor unsuccessfully attempts to upload their photo" do
    category = Category.create(name: "new category")
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1")
    UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit("/dashboard/#{user.id}")
    within(".side-menu") do
      click_on "Vendor1"
    end
    within("#vendor1-form") do
      fill_in "Photo Title", with: ""
      fill_in "Photo Description", with: "very lux"
      fill_in "photo[price]", with: 1000.00
      find("option[value='#{category.id}']").click
      click_on "Create Photo"
    end

    expect(current_path).to eq(dashboard_path(user.id))
    expect(page).not_to have_content("Photo: Super Lux Created")
    expect(page).to have_content("Title can't be blank")
  end
end
