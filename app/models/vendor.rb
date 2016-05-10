class Vendor < ActiveRecord::Base
  before_create :generate_slug

  has_many :photos

  validates_presence_of :name

  def generate_slug
    self.slug = self.name.parameterize
  end
end
