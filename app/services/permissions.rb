class Permissions
  extend Forwardable

  def_delegators :user, :platform_admin?,
                        :vendor_admin?,
                        :customer?


  def initialize(user, controller, action)
    @_user = user || User.new
    @_controller = controller
    @_action = action
  end


  def allow?
    case
    when platform_admin? then platform_admin_permissions
    when vendor_admin? then vendor_admin_permissions
    when customer? then customer_permissions
    else guest_permissions
    end
  end

  private

    def platform_admin_permissions
      vendor_admin_permissions ||
      controller == "platform_admin/vendors" ||
      controller == "platform_admin/dashboard" ||
      controller == "platform_admin/photos"
    end

    def vendor_admin_permissions
      return true if controller == "vendor_admin/vendors"
      customer_permissions ||
      controller == "photos" && action.in?(%w(create))
    end

    def customer_permissions
      guest_permissions || controller == "users" && action.in?(%w(show edit update)) ||
      controller == "orders" && action.in?(%w(index create show)) ||
      controller == "downloads" && action.in?(%w(show))
    end

    def guest_permissions
      return true if controller == "sessions"
      return true if controller == "vendors" && action.in?(%w(show index))
      return true if controller == "categories" && action.in?(%w(show))
      return true if controller == "photos" && action.in?(%w(index show))
      return true if controller == "carts" && action.in?(%w(show create destroy update))
      return true if controller == "users" && action.in?(%w(new create show))
    end

    def controller
      @_controller
    end

    def action
      @_action
    end

    def user
      @_user
    end
end
