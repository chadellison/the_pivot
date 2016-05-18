require 'rails_helper'

RSpec.feature "Vendor can add another vendor admin" do
  scenario "vendor adds another vendor_admin" do
    # byebug
    # category = Category.create(name: "new category")
    user = User.create(username: "FirstAdmin", password: "password", password_confirmation: "password", email: "who@gmail.com" )
    role = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1")
    UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit("/vendor_admin/vendors/#{vendor.id}")
    click_on "Create Another Admin"

    expect(current_path).to eq(new_vendor_admin_user_path)
    within ".login_form" do
      fill_in "Username", with: "SecondAdmin"
      fill_in "Email", with: "second_admin_email@gmail.com"
      fill_in "Password", with: "password"
      fill_in "Password confirmation", with: "password"
    end
    click_on "Add Admin"
    save_and_open_page
    expect(page).to have_content "New Admin Created for Vendor1"
    expect(page).to have_content "Username: SecondAdmin"
    expect(page).to have_content "Email: second_admin_email@gmail.com"

    # byebug
  end
end
