class CategoriesController < ApplicationController

  def show
    @category = Category.find_by(slug: params[:name])
    @photos = @category.photos
  end

end
