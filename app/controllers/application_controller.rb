class ApplicationController < ActionController::Base
  helper_method :current_user
  rescue_from ActiveRecord::RecordNotFound, with: :record_or_routing_not_found
  rescue_from ActionController::RoutingError, with: :record_or_routing_not_found

  private
    def current_user
      @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end

    def record_or_routing_not_found
      render file: "#{Rails.root}/public/404.html", status: :not_found
    end

end
