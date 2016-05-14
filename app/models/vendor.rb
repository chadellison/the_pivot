class Vendor < ActiveRecord::Base
  before_create :generate_slug

  has_many :photos
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :orders, through: :order_photos

  validates_presence_of :name

  def featured
    photos.first
  end

  def generate_slug
    self.slug = name.parameterize
  end
end
