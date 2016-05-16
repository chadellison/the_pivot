require "rails_helper"

RSpec.feature "Admin can remove photos" do
  scenario "Admin sees that the photo is removed" do
    vendor = Vendor.create(name: "Jojo blu", status: "Active")
    photo = Photo.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description", vendor_id: vendor.id)
    vendor.photos << photo

    admin = User.create(username: "Jones", password: "password", password_confirmation: "password", email: "jones@gmail.com")
    admin.roles.create(name: "platform_admin")

    visit root_path
    expect(page).to have_content "photo"

    ApplicationController.any_instance.stubs(:current_user).returns(admin)

    visit platform_admin_dashboard_path(admin.id)
    click_on "Edit Photos"

    click_button "Delete"
    expect(vendor.photos.all).to eq []

    expect(page).to have_content "#{photo.title} was successfully removed"

    expect(Vendor.find(vendor.id).photos).to eq []

    visit root_path
    expect(page).not_to have_content "photo"
  end

  scenario "non-admins cannot remove photos" do
    user = User.create(username: "Mia", password: "password", password_confirmation: "password", email: "mia@gmail.com")
    user.roles.create(name: "vendor_admin")

    visit platform_admin_photos_path
    expect(page).to have_content "404"
  end
end
