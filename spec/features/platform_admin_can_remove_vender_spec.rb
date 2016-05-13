require "rails_helper"

RSpec.feature "platform admin can remove a vendor" do
  scenario "vendor is no longer displayed on" do
    role = Role.create(name: "platform_admin")
    user = User.create(username: "Jones", password: "password", password_confirmation: "password", email: "jones@gmail.com")
    user.roles << role

    vendor = Vendor.create(name: "Jojo blu")
    photo = Photo.create(title: "photo", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")

    vendor.photos << photo

    visit root_path

    # expect(page).to have_content "photo"

    click_on "Login"
    fill_in "Username", with: "Jones"
    fill_in "Password", with: "password"
    click_on "Sign In"

    expect(page).to have_content "Status: Admin"
    click_button "Vendors"
    expect(current_path).to eq platform_admin_vendors_path
    within("li") do
      expect(page).to have_content "Jojo blu"
    end
    click_button "Delete"
    expect(page).to have_content "Jojo blu was successfully removed!"
    expect(Vendor.all).to eq []

    visit root_path
    # expect(page).not_to have_content "Photo"
  end

  scenario "non-admins cannot remove vendors" do
    user = User.create(username: "Rosco", password: "password", password_confirmation: "password", email: "jones@gmail.com")
    reg_user = Role.create(name: "customer")

    vendor = Role.create(name: "vendor_admin")

    visit platform_admin_vendors_path
    expect(page).to have_content "404"

    user.roles << reg_user

    visit root_path
    click_on "Login"
    fill_in "Username", with: "Rosco"
    fill_in "Password", with: "password"
    click_on "Sign In"

    visit platform_admin_vendors_path
    expect(page).to have_content "404"

    user.roles << vendor

    visit platform_admin_vendors_path
    expect(page).to have_content "404"
  end
end
