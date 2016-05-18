class UploadPhotoParser

  attr_reader :photo_info, :vendor, :category

  def initialize(params)
    @photo_info = { title: params[:title],
                  description: params[:description],
                  price: params[:price],
                  image: params[:image][:photo]}
    @vendor = Vendor.find_by(name: params[:vendor])
    @category = Category.find(params[:category])
  end

end
