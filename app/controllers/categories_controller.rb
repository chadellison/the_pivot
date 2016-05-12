class CategoriesController < ApplicationController

  def show
    byebug
    @category = Category.find_by(slug: params[:name])
    @photos = category.photos
  end





  # def show
  #   @category = Category.find_by(name: params[:name])
  #   render file: "/public/404" unless @category
  # end

end
