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

  it "has a default status of 'inactive'" do
    vendor = Vendor.create(name: "Hoss beast")
    expect(vendor.status).to eq "Inactive"
    vendor.update(status: "Active")
    expect(Vendor.find(vendor.id).status).to eq "Active"
  end
end
