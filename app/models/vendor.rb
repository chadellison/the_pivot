class Vendor < ActiveRecord::Base
  before_create :generate_slug

  has_many :photos
  has_many :vendor_admins
  has_many :users, through: :vendor_admins

  validates_presence_of :name

  def generate_slug
    self.slug = self.name.parameterize
  end
end
