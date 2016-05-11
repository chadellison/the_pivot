require 'rails_helper'

RSpec.feature "Vendor can login" do
  scenario "vendor opens their dashboard" do
    visit login_path
    user = User.create(name: "test", password: "pass", email: "who@gmail.com" )
    vendor = Vendor.create(name: "Vendor1")

    within ".login_form" do
      fill_in "Username", with: user.name
      fill_in "Password", with: user.password
      click_button "Sign In"
    end

    expect(current_path).to eq("/#{vendor.slug}/dashboard")
    expect(page).to have_content(vendor.name)
    expect(page).to have_button("Upload Photo")
  end
end
