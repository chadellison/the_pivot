class OrderPackage < ActiveRecord::Base
  belongs_to :user
  belongs_to :order
  belongs_to :package

  validates_presence_of :order_id, :package_id
end
