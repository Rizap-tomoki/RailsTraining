class ApplicationController < ActionController::Base
  helper_method :current_user

  def render_404
    respond_to do |format|
      format.html { render file: "#{Rails.root}/public/404.html", status: :not_found }
    end
  end
  
  private
    def current_user
      @_current_user ||= session[:current_user_id] &&
        User.find_by(id: session[:current_user_id])
    end
end
