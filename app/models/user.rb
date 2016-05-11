class User < ActiveRecord::Base
  has_many :orders
  has_many :vendor_admins
  has_many :vendors, through: :vendor_admins
  has_secure_password
  validates_presence_of :username, :email, :password, :password_confirmation
  validates :username, :email, uniqueness: true

  def vendor?#(business)
    # byebug
    # business.id == vendors.id
  end
end
