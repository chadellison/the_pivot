class Vendor < ActiveRecord::Base
  before_create :generate_slug

  has_many :photos
  has_many :user_roles
  has_many :users, through: :user_roles

  validates_presence_of :name

  def generate_slug
    self.slug = self.name.parameterize
  end
end
