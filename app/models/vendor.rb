class Vendor < ActiveRecord::Base
  before_create :generate_slug
  has_many :photos
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :orders, through: :order_photos
  has_attached_file :logo
  validates_attachment_content_type :logo, content_type: ["image/jpg", "image/jpeg", "image/png"]
  validates_presence_of :name

  enum status: %w(pending active inactive)

  def featured
    photos.first
  end

  def generate_slug
    self.slug = name.parameterize
  end
end
