require 'rails_helper'

RSpec.feature "guest can create a new user account" do
  scenario "guest selects create account and fills in their information" do
    original_user_count = User.count

    visit users_path

    expect(current_path).to eq(users_path)
    expect(page).to have_content("Please Create an Account")
    expect(page).to have_field("Username")
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")

    fill_in "Username", with: "JoeSmith"
    fill_in "Email", with: "j1@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Success! Your account was created!.")
  end
  #   expect(page).to have_content(vendor.name)
  #   expect(page).to have_xpath("//img[@src=\"#{photo.image}\"]")
  #   expect(page).to have_link(photo.image.url, href: photo_path(photo))
  # end
  #
  # scenario "guest doesn't see pictures for a vendor that doesn't exist" do
  #   vendor = Vendor.create(name: "vendor")
  #   photo = vendor.photos.create(title: "photo", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
  #
  #   visit "/something-else"
  #
  #   expect(page).to have_content('404')
  # end
end
