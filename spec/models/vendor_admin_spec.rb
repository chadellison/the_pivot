require 'rails_helper'

RSpec.describe VendorAdmin, type: :model do
  context "validations" do
    it {is_expected.to validate_presence_of(:user_id)}
    it {is_expected.to validate_presence_of(:vendor_id)}
    it {should belong_to :user}
    it {should belong_to :vendor}
  end
end
