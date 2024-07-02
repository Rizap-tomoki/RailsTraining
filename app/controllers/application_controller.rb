class ApplicationController < ActionController::Base
  helper_method :current_user
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  def render_404
    respond_to do |format|
      format.html { render template: 'error/404', status: 404 }
    end
  end

  def routing_error
    render_404
  end
  private
    def current_user
      @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end
end
