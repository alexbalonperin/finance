class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # around_filter :catch_exception

  def catch_exception
    yield
  rescue StandardError => exception
    flash[:error] = exception.message
    logger.error("WARNING: #{exception.message}")
    redirect_to '/'
  end

end
