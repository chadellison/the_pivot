require 'rails_helper'

RSpec.feature "guest can visit a vendor" do
  scenario "guest sees a vendor's pictures" do
    vendor = Vendor.create(name: "vendor")
    photo = vendor.photos.create(title: "photo", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")

    #   As a Guest
    # When I visit /business1
    visit "/#{vendor.name}"

    # I expect to see vendor1's photos
    expect(page).to have_content(vendor.name)
    expect(page).to have_xpath("//img[@src=\"#{photo.image}\"]")
    expect(page).to have_link(photo.image.url, href: photo_path(photo))
  end
end
