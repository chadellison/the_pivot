class User < ActiveRecord::Base
  has_many :orders
  has_many :user_roles
  has_many :vendors, through: :user_roles
  has_many :roles, through: :user_roles
  has_secure_password
  validates_presence_of :username, :email, :password, :password_confirmation
  validates :username, :email, uniqueness: true
  # scope :platform_admin?, -> { roles.exists?(name: "platform_admin") }

  def platform_admin?
    roles.exists?(name: "platform_admin")
  end

  def vendor_admin?
    roles.exists?(name: "vendor_admin")
  end

  def customer?
    roles.exists?(name: "customer")
  end

end
