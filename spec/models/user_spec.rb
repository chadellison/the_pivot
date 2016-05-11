require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    it {is_expected.to validate_presence_of(:username)}
    it {is_expected.to validate_uniqueness_of(:username)}
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_uniqueness_of(:email)}
    it {is_expected.to validate_presence_of(:password)}
    it {is_expected.to validate_presence_of(:password_confirmation)}
    it {should have_many(:vendors)}
    it {should have_many(:roles)}
  end
end
