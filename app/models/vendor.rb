class Vendor < ActiveRecord::Base
  before_create :generate_slug

  has_many :photos

  def generate_slug
    self.slug = self.name.parameterize
  end
end
