require 'rails_helper'

RSpec.feature "guest can visit a vendor" do
  scenario "guest sees a vendor's pictures" do
    vendor = Vendor.create(name: "vendor")
    photo = vendor.photos.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description", vendor_id: vendor.id)

    visit "/#{vendor.name}"

    expect(page).to have_content(vendor.name)
    expect(page).to have_xpath("//img[@src=\"#{photo.image}\"]")
    expect(page).to have_link(photo.image.url, href: photo_path(photo))
  end

  scenario "guest doesn't see pictures for a vendor that doesn't exist" do
    vendor = Vendor.create(name: "vendor")
    photo = vendor.photos.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description", vendor_id: vendor.id)

    visit "/something-else"

    expect(page).to have_content('404')
  end
end
