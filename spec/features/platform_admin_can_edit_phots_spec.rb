require "rails_helper"

RSpec.feature "Platform admin can edit photos" do
  scenario "all users see photo's updated status" do
    user = User.create(username: "Lux", password: "password", password_confirmation: "password", email: "lux@gmail.com")
    user.roles.create(name: "platform_admin")
    category = Category.create(name: "new category")

    vendor = Vendor.create(name: "the ninja", status: 1)
    vendor.photos.create(title: "kung fu", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description", vendor_id: vendor.id)

    visit root_path
    expect(page).to have_content "kung fu"

    click_on "Login"
    fill_in "Username", with: "Lux"
    fill_in "Password", with: "password"
    click_on "Sign In"

    visit platform_admin_dashboard_path(user.id)
    click_on "Edit Photos"
    expect(current_path).to eq platform_admin_photos_path
    expect(page).to have_content "kung fu"

    click_on "Edit"
    fill_in "Photo Title", with: "Super kung fu"
    fill_in "Photo Description", with: "very lux"
    fill_in "Choose a Price for the New Photo", with: 1000.00
    find("option[value='#{category.id}']").click
    click_on "Update Photo"

    expect(page).to have_content "Super kung fu has been updated."
    expect(current_path).to eq platform_admin_photos_path

    visit root_path
    expect(page).to have_content "Super kung fu"
  end
end
