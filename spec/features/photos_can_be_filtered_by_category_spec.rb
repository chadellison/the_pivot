require "rails_helper"


RSpec.feature "Guest visits category path" do
  scenario "user can view only photos with selected category" do
    category1 = Category.create(name: "Nature")
    category2 = Category.create(name: "Sports")
    vendor1 = Vendor.create(name: "vendor")
    photo1 = Photo.create(title: "photo", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description", vendor_id: vendor1.id)
    photo2 = Photo.create(title: "this", image: File.new("#{Rails.root}/spec/support/fixtures/people_1.jpg"), price: 20, description: "description", vendor_id: vendor1.id)
    category1.photos << photo1
    category1.photos << photo2

    visit category_path("nature")


    expect(current_path).to eq("/category/nature")
    expect(page).to have_content("Nature")
    expect(page).to have_xpath("//img[@src=\"#{photo1.image}\"]")
    expect(page).to have_xpath("//img[@src=\"#{photo2.image}\"]")
  end
end
