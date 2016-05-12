require 'rails_helper'

RSpec.describe PhotoCategory, type: :model do
  it {should belong_to(:photo)}
  it {should belong_to(:category)}
end
