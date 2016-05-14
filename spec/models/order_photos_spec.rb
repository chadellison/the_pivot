require 'rails_helper'

RSpec.describe OrderPhoto, type: :model do
  it { should belong_to(:vendor) }
  it { should belong_to(:order) }
  it { should belong_to(:photo) }
end
