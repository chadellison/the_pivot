class Seeds

  def initialize
    create_categories
    create_roles
    create_vendors_and_photos
    create_users
  end

  def create_categories
    puts "Creating Categories"
    Category.create(name: "All")
    Category.create(name: "Nature")
    Category.create(name: "Animals")
    Category.create(name: "People")
    Category.create(name: "Places")
    Category.create(name: "Things")
    Category.create(name: "Machines")
    Category.create(name: "Cities")
    Category.create(name: "Farms")
    Category.create(name: "Sports")
    puts "Created Categories"
  end

  def create_users
    user1 = User.create(username: Faker::Internet.user_name, password: "password", password_confirmation: "password", email: Faker::Internet.email)
    user2 = User.create(username: Faker::Internet.user_name, password: "password", password_confirmation: "password", email: Faker::Internet.email)
    user3 = User.create(username: Faker::Internet.user_name, password: "password", password_confirmation: "password", email: Faker::Internet.email)
    role1 = Role.find_by(name: "customer")
    role2 = Role.find_by(name: "vendor_admin")
    role3 = Role.find_by(name: "platform_admin")
    vendors = Vendor.all.sample(2)
    vendors.each do |vendor|
      UserRole.create(user_id: user2.id, role_id: role2.id, vendor_id: vendor.id)
    end
    puts "created users"
  end

  def create_roles
    Role.create(name: "platform_admin")
    Role.create(name: "vendor_admin")
    Role.create(name: "customer")
    puts "created roles"
  end

  def create_vendors_and_photos
    20.times do
      vendor = Vendor.create(name: Faker::Company.name,
                             about: Faker::Hipster.paragraph)
      rand(1..10).times do
        category = %w(buildings food nature people technology objects).sample
        vendor.photos.create(title: Faker::Hipster.sentence,
                             description: Faker::Hipster.paragraph(2),
                             price: Faker::Commerce.price,
                             image: Photo.image_from_url("https://source.unsplash.com/category/#{category}/1200x600"))
        puts "created vendor and photos"
      end
    end
  end
end


Seeds.new
