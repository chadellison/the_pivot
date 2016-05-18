require 'rails_helper'

RSpec.feature "A user can add photos to their cart" do
  scenario "registered user can add photos from different vendors to one cart" do
    Role.create(name: "customer")
    user = User.new(id: 1 )
    user.save(validates: false)
    user.roles << Role.find_by(name: "customer")
    vendor1 = Vendor.create(name: "vendor1")
    vendor2 = Vendor.create(name: "vendor2")
    photo1 = vendor1.photos.create(title: "photo", image:  File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description")
    photo2 = vendor2.photos.create(title: "photo2", image:  File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 2, description: "description2")

    visit '/vendor1'
    click_on "Purchase"
    expect(current_path).to eq '/vendor1'
    visit '/vendor2'
    click_on "Purchase"
    visit '/cart'

    within '.photo' do
      expect(page).to have_content "1"
      expect(page).to have_content "$20"
      expect(page).to have_xpath("//img[@src=\"#{photo1.image}\"]")
      expect(page).to have_content "vendor1"
      expect(page).to have_content "2"
      expect(page).to have_content "2"
      expect(page).to have_content "$2"
      expect(page).to have_xpath("//img[@src=\"#{photo2.image}\"]")
    end
    expect(page).to have_content "Total: $22"
  end

  scenario "registered user can remove photos from their cart" do
    Role.create(name: "customer")
    user = User.new(id: 1 )
    user.save(validates: false)
    user.roles << Role.find_by(name: "customer")
    vendor1 = Vendor.create(name: "vendor1")
    photo1 = vendor1.photos.create(title: "photo", image:  File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description")

    visit '/vendor1'
    click_on "Purchase"
    visit '/cart'
    find(".fi-x").click

    expect(page).to have_content "Your Cart is Empty"
  end

  scenario "guest cannot checkout and sees a button that asks them to login before continueing" do
    vendor1 = Vendor.create(name: "vendor1")
    photo1 = vendor1.photos.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description")

    visit '/vendor1'
    click_on "Purchase"
    visit '/cart'

    within(".cart") do
      expect(page).to have_link "Login or Create Account to Purchase", href: login_path
    end
  end
end
