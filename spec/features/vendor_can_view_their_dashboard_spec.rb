require 'rails_helper'

RSpec.feature "Vendor can login" do
  scenario "vendor opens their dashboard" do
    visit login_path
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    vendor = user.vendors.create(name: "Vendor1")

    # within ".login_form" do
    # save_and_open_page
      fill_in "Username", with: user.username
      fill_in "Password", with: user.password
      click_button "Sign In"
    # end

    expect(current_path).to eq dashboard_path(user.id)
    expect(page).to have_content(vendor.name)
  end
end
