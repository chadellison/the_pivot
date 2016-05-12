require "rails_helper"


RSpec.feature "Photo is given a category" do
  scenario "user can filter only photos with that category" do
    user = User.create(username: "test", password: "pass", password_confirmation: "pass", email: "who@gmail.com" )
    role = Role.create(name: "vendor_admin")
    vendor = Vendor.create(name: "Vendor1")
    UserRole.create(user_id: user.id, vendor_id: vendor.id, role_id: role.id)
    photo1 = vendor1.photos.create(title: "photo", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
    photo2 = vendor2.photos.create(title: "this", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
    photo3 = vendor3.photos.create(title: "another", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
    photo4 = vendor4.photos.create(title: "and this", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description")
    

  end
end
