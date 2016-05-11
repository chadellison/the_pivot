require 'rails_helper'

RSpec.describe UserRole, type: :model do
  context "validations" do
    it {is_expected.to validate_presence_of(:user_id)}
    it {is_expected.to validate_presence_of(:role_id)}
    it {should belong_to :user}
    it {should belong_to :vendor}
    it {should belong_to :role}
  end
end
