class Order < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user
  has_many :order_photos
  has_many :photos, through: :order_photos

  def total_quantity
    order_photos.count
  end

  def subtotal(photo)
    photo.price
  end

  def photo_names
    photos.pluck(:title).join(", ")
  end

  def photo_vendors
    photos.includes(:vendor).pluck(:name).join(",")
  end

  def user_demographic
    user.vendors
  end

end
