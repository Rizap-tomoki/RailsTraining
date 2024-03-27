class Admin::SessionController < ApplicationController
    def new
    end

    def create
      user = User.find_by(mail: params[:mail])
      if user && user.authenticate(params[:password])
        session[:current_user_id] = user.id
        redirect_to admin_users_path
      else
        flash[:alert] = "メールアドレスかパスワードが間違っています"
        render :new, status: :unauthorized
      end
    end

    def destroy
      reset_session
      redirect_to new_admin_session_url, status: :see_other
    end
end