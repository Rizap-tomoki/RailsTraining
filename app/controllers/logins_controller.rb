class LoginsController < ApplicationController
    def new
    end

    def create
      if user = User.find_by(mail: params[:mail])
        session[:current_user_id] = user.id
        redirect_to admin_users_path
      else
        flash[:alert] = "メールアドレスが間違っています"
        render :new, status: :unauthorized
      end
    end

    def destroy
      session.delete(:current_user_id)
      @_current_user = nil
      redirect_to new_login_url, status: :see_other
    end
end