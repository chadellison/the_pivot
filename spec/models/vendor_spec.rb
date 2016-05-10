require 'rails_helper'

RSpec.describe Vendor, type: :model do
  context "validations" do
    it {is_expected.to validate_presence_of(:name)}
    it {should have_many(:photos)}
  end

  it "can create a slug" do
    vendor = Vendor.create(name: "vendor's favorites")

    expect(vendor.slug).to eq("vendor-s-favorites")
  end
end
