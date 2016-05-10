require 'rails_helper'

RSpec.describe Photo, type: :model do
  context "validations" do
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_presence_of(:price)}
    it {is_expected.to validate_presence_of(:description)}
    it {should belong_to(:vendor)}
  end
end
