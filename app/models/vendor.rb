class Vendor < ActiveRecord::Base
  before_create :generate_slug
  has_many :photos
  has_many :user_roles
  has_many :users, through: :user_roles
  has_many :order_photos
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

  def most_popular_photos
    photo_ids = OrderPhoto.where(vendor_id: id).group(:photo_id).count
    photo_ids.reduce({}) do |hash, photo|
      photo_name = Photo.find(photo[0]).title
      hash[photo_name] = photo[1]
      hash
    end
  end

  def customer_demographic
    user_ids = Order.where(id: order_ids).pluck(:user_id)
    User.where(id: user_ids).group(:country).count
  end

  def order_ids
    OrderPhoto.where(vendor_id: id).pluck(:order_id)
  end
end
