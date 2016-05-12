require "rails_helper"

RSpec.feature "visitor can view a single photo" do
  scenario "user sees photo with its description, vender, and price" do
    vender = Vendor.create(name: "Jones and photos")
    photo = vender.photos.create(title: "You're not a real hipster",
                                 description: "This is a description",
                                 price: 10,
                                 image: Photo.image_from_url("https://source.unsplash.com/category/people/800x600/"))

    # image = find(:xpath, "a[contains(@href,'#{photo.image}')]")
    visit photo_path(photo.id)
    # image.click
    expect(page).to have_content "Price: $10.00"
    expect(page).to have_content "By: Jones and photos"
    expect(page).to have_content "This is a description"
  end
end
