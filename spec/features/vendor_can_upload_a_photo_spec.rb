require 'rails_helper'
require 'spec_helper'

  include FeatureHelper

RSpec.feature "Vendor can upload a photo" do
  scenario "vendor uploads their photo", js: true do
    category = Category.create!(name: "new category")
    user = User.create!(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create!(name: "vendor_admin")
    vendor = Vendor.create!(name: "Vendor1")
    UserRole.create!(user_id: user.id, vendor_id: vendor.id, role_id: role.id)

    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit "/dashboard/#{user.id}"

    expect(current_path).to eq "/dashboard/#{user.id}"

    within(".side-menu") do
      click_on "Vendor1"
    end

    image = Rails.root.join("spec/support/fixtures/people_1.jpg")

    drop_in_dropzone image

    within("#photoForm") do
      fill_in "Photo Title", with: "Super Lux"
      fill_in "Photo Description", with: "very lux"
      fill_in "photo[price]", with: 1000.00
      click_on "Upload"
    end

    sleep(5)

    photo = Photo.last

    expect(photo.title).to eq "Super Lux"
    expect(photo.description).to eq "very lux"
    expect(photo.price).to eq 1000
    expect(photo).to respond_to(:image)
  end
end
