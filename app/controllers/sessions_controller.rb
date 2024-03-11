class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(mail: params[:session][:mail].downcase)
    if user
      session[:user_id] = user.id
      redirect_to admin_user_path(user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end
end
