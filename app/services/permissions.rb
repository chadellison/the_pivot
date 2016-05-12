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
      vendor_admin_permissions
    end

    def vendor_admin_permissions
      return true if controller == "photos" && action.in?(%w(create show))
      return true if controller == "users" && action.in?(%w(show))
      return true if controller == "sessions"
      return true if controller == "vendors" && action.in?(%w(show))
      return true if controller == "photos" && action.in?(%w(index))
    end

    def customer_permissions
      return true if controller == "users" && action.in?(%w(show))
      return true if controller == "sessions"
      return true if controller == "vendors" && action.in?(%w(show))
      return true if controller == "photos" && action.in?(%w(index))
    end

    def guest_permissions
      return true if controller == "sessions"
      return true if controller == "vendors" && action.in?(%w(show))
      return true if controller == "photos" && action.in?(%w(index))
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
