class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # around_filter :catch_exception

  def sanitize_order_params
    @sort = params[:sort]
    @order = params[:order]
    raise SecurityException.new("Sort parameter '#{@sort}' not allowed for #{self.class}") unless @sort.nil? || self.columns.include?(@sort)
    raise SecurityException.new("Order parameter '#{@order}' not allowed for #{self.class}") unless %w[asc desc].include?(@order)
  end

  def catch_exception
    yield
  rescue StandardError => exception
    flash[:error] = exception.message
    logger.error("WARNING: #{exception.message}")
    redirect_to root_path
  end

  class SecurityException < StandardError
  end

  rescue_from SecurityException, :with => :security_exception

  def security_exception(exception)
    Rails.logger.info "Exception: #{exception.message}. IP Address: #{request.remote_ip}"
    redirect_to root_path
  end

end
