require "rails_helper"


RSpec.feature "Guest visits category path" do
  scenario "user can view only photos with selected category" do
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create(name: "customer")
    category1 = Category.create(name: "Nature")
    category2 = Category.create(name: "Sports")
    UserRole.create(user_id: user.id, role_id: role.id)
    photo1 = Photo.create(title: "photo", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
    photo2 = Photo.create(title: "this", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
    photo3 = Photo.create(title: "another", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
    photo4 = Photo.create(title: "and this", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
    photo5 = Photo.create(title: "and one more", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
    category1.photos << photo1
    category1.photos << photo2
    category1.photos << photo3
    category2.photos << photo4
    category2.photos << photo5

    visit category_path("nature")
    byebug
    save_and_open_page

    expect(current_path).to eq("/photos/category/nature")
    expect(page).to have_content("Nature")
    expect(page).to have_xpath("//img[@src=\"#{photo1.image}\"]")
    expect(page).to have_xpath("//img[@src=\"#{photo2.image}\"]")
    expect(page).to have_xpath("//img[@src=\"#{photo3.image}\"]")
    expect(page).to have_no_xpath("//img[@src=\"#{photo4.image}\"]")
    expect(page).to have_no_xpath("//img[@src=\"#{photo5.image}\"]")
  end
end
