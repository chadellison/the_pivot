require 'rails_helper'

RSpec.describe Vendor, type: :model do
  context "validations" do
    it {is_expected.to validate_presence_of(:name)}
    it {should have_many(:photos)}
    it {should have_many(:users)}
  end

  it "can create a slug" do
    vendor = Vendor.create(name: "vendor's favorites")

    expect(vendor.slug).to eq("vendor-s-favorites")
  end

  it "can retrieve the featured photo" do
    vendor = Vendor.create(name: "vendor's favorites")
    photo1 = Photo.create(title: "photo1", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description", vendor_id: vendor.id)
    photo2 = Photo.create(title: "photo2", image: Photo.image_from_url("https://source.unsplash.com/random"), price: 20, description: "description", vendor_id: vendor.id)

    expect(vendor.featured).to eq(photo1)
  end

  it "has a default status of 'pending'" do
    vendor = Vendor.create(name: "Hoss beast")
    expect(vendor.status).to eq "pending"
    vendor.update(status: "active")
    expect(Vendor.find(vendor.id).status).to eq "active"
  end
end
