class Category < ActiveRecord::Base
  before_create :generate_slug

  has_many :photo_categories
  has_many :photos, through: :photo_categories

  def generate_slug
    self.slug = self.name.parameterize
  end
end
