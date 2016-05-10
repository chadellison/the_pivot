module ApplicationHelper
  def format_time(time)
    time.strftime("%B %d, %Y @ %l:%M%p")
  end
end
