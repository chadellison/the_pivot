require 'rails_helper'

RSpec.feature "Guest visits root path" do
  scenario "guest sees all photos" do
    vendor1 = Vendor.create(name: "vendor")
    vendor2 = Vendor.create(name: "jones")
    vendor3 = Vendor.create(name: "Mark")
    vendor4 = Vendor.create(name: "Bob")
    photo1 = vendor1.photos.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description")
    photo2 = vendor2.photos.create(title: "this", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description")
    photo3 = vendor3.photos.create(title: "another", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description")
    photo4 = vendor4.photos.create(title: "and this", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description")

    visit root_path
    expect(page).to have_xpath("//img[@src=\"#{photo1.image}\"]")
    expect(page).to have_xpath("//img[@src=\"#{photo2.image}\"]")
    expect(page).to have_xpath("//img[@src=\"#{photo3.image}\"]")
    expect(page).to have_xpath("//img[@src=\"#{photo4.image}\"]")
    expect(page).to have_link(photo1.image.url, href: photo_path(photo1))
  end

  scenario "guest sees nav options" do
    visit root_path
    within(".nav-bar") do
      expect(page).to have_link "Categories"
      expect(page).to have_link "Vendors"
      expect(page).to have_link "Login"
      expect(page).to have_link "Eccentric Photos", href: root_path
      expect(page).not_to have_link "Logout"
    end
  end
end
