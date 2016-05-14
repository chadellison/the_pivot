class Order < ActiveRecord::Base
  include ApplicationHelper

  belongs_to :user
  has_many :order_photos
  has_many :photos, through: :order_photos


  def photo_total_price
    photos.sum(:price)
  end

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

end
