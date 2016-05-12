require 'rails_helper'

RSpec.describe PhotoCategory, type: :model do
  it {should have_many(:photos)}
  it {should have_many(:categories)}
end
