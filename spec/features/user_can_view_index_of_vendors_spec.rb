require 'rails_helper'

RSpec.feature "User can view index of vendors" do
  scenario "user goes to path '/vendors' and sees all vendors" do


    # user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    # role = Role.create(name: "vendor_admin")
    vendor1 = Vendor.create(name: "Store Name1")
    photo1 = Photo.create(title: "photo1", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description", vendor_id: vendor1.id)
    photo2 = Photo.create(title: "photo2", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description", vendor_id: vendor1.id)

    vendor2 = Vendor.create(name: "Store Name2")
    photo3 = Photo.create(title: "photo3", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description", vendor_id: vendor2.id)
    photo4 = Photo.create(title: "photo4", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description", vendor_id: vendor2.id)

    vendor3 = Vendor.create(name: "Store Name3")
    photo5 = Photo.create(title: "photo5", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description", vendor_id: vendor3.id)
    photo6 = Photo.create(title: "photo6", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description", vendor_id: vendor3.id)

    # UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)

    visit vendors_path
    # byebug
    within(".vendor-index") do
      expect(page).to have_content("Store Name1")
      # byebug
      # save_and_open_page
      expect(page).to have_xpath("//img[@src=\"#{photo1.image}\"]")

      expect(page).to have_content("Store Name2")
      expect(page).to have_xpath("//img[@src=\"#{photo3.image}\"]")

      expect(page).to have_content("Store Name3")
      expect(page).to have_xpath("//img[@src=\"#{photo5.image}\"]")
    end



    # fill_in "Username", with: "test"
    # fill_in "Password", with: "pass"
    # click_button "Sign In"
    # visit '/dashboard/1'
    #
    # fill_in "Photo Title", with: "Super Lux"
    # fill_in "Photo Description", with: "very lux"
    # fill_in "Choose a Price for the New Photo", with: 1000.00
    #
    # click_on "Create Photo"
    # expect(current_path).to eq(dashboard_path(user.id))
    # expect(page).to have_content("Photo: Super Lux Created")
  end
end
