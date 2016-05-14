class OrderPhoto < ActiveRecord::Base
  belongs_to :vendor
  belongs_to :order
  belongs_to :photo

  validates_presence_of :order_id, :photo_id, :vendor_id
end
