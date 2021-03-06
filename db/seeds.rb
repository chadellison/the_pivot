class Seeds

  def initialize
    create_categories
    create_roles
    create_vendors_and_photos
    create_vendor_admins
    create_platform_admin
    create_pending_vendors
    create_customers
  end

  def create_categories
    categories = %w(buildings food nature people technology objects)
    categories.each do |category|
      Category.create(name: category)
    end
    puts "Created Categories"
  end

  def create_platform_admin
    user = User.create(username: "jorge@turing.io",
                password: "password",
                password_confirmation: "password",
                email: "jorge@gmail.com")
    user.roles << Role.first
    puts "created platform admin"
  end

  def create_vendor_admins
    user = User.create(username: Faker::Internet.user_name, password: "password", password_confirmation: "password", email: Faker::Internet.email)
    role = Role.find_by(name: "vendor_admin")
    vendors = Vendor.all.sample(2)
    vendors.each do |vendor|
      UserRole.create(user_id: user.id, role_id: role.id, vendor_id: vendor.id)
    end
    user = User.create(username: "andrew@turing.io", password: "password", password_confirmation: "password", email: "andrew@turing.io", country: "Argentina")
    user.user_roles.create(role: Role.find_by(name: "vendor_admin"), vendor: Vendor.first)
    puts "created vendor for andrew"
    puts "created vendor admins"
  end

  def create_customers
    10.times do
      user = User.create(username: Faker::Internet.user_name,
                  password: "password",
                  password_confirmation: "password",
                  email: Faker::Internet.email,
                  country: Faker::Address.country)
      end
    User.create(username: "josh@turing.io", password: "password", password_confirmation: "password", email: "josh@turing.io", country: "Germany")
  end

  def create_roles
    Role.create(name: "platform_admin")
    Role.create(name: "vendor_admin")
    puts "created roles"
  end

  def create_vendors_and_photos
    headshots = Dir.entries("#{Rails.root}/app/assets/staff_headshots")
    headshots.delete_if do |photo|
      photo[-3..-1] != "png"
    end
    20.times do
      headshot = headshots.sample
      vendor = Vendor.create(name: Faker::Company.name,
                             about: Faker::Hipster.paragraph,
                             status: "active",
                             logo: File.new("#{Rails.root}/app/assets/staff_headshots/#{headshot}"))

      category = %w(buildings food nature people technology objects).sample
      user = User.create(username: Faker::Internet.user_name,
                         password: "password",
                         password_confirmation: "password",
                         email: Faker::Internet.email,
                         country: Faker::Address.country)
      role = Role.find_by(name: "vendor_admin")
      UserRole.create(user_id: user.id, role_id: role.id, vendor_id: vendor.id)

      rand(1..10).times do
        photo = vendor.photos.create(title: Faker::Hipster.sentence,
                             description: Faker::Hipster.paragraph(2),
                             price: Faker::Commerce.price,
                             image: Photo.image_from_url("https://source.unsplash.com/category/#{category}/1200x600"))
        photo.categories << Category.find_by(name: "#{category}")
        puts "created vendor and photos"
      end
    end
  end

  def create_pending_vendors
    5.times do
      vendor = Vendor.create(name: Faker::Company.name,
                             about: Faker::Hipster.paragraph,
                             status: "pending")

      user = User.create(username: Faker::Internet.user_name, password: "password", password_confirmation: "password", email: Faker::Internet.email)
      UserRole.create(user: user, role: Role.find_by(name: "vendor_admin"), vendor: vendor)
    end
    puts "created pending vendors"
  end

end

Seeds.new
