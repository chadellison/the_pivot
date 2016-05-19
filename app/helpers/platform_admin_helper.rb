module PlatformAdminHelper
  def user_demographics
    User.group(:country).count
  end
end
