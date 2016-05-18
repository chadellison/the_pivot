class Photo < ActiveRecord::Base
  belongs_to :vendor
  has_attached_file :image,
                    :s3_domain_url =>"pivot-assets.s3.amazonaws.com",
                    :bucket => 'pivot-assets',
                    :s3_permissions => :public_read,
                    :encode => 'utf8'

  has_many :photo_categories
  has_many :categories, through: :photo_categories
  has_many :orders, through: :order_photos
  validates_attachment_content_type :image, content_type: ["image/jpg", "image/jpeg", "image/png"]
  validates_presence_of :title, :description, :price

  def self.image_from_url(url)
    image = URI.parse(url)
  end
end
