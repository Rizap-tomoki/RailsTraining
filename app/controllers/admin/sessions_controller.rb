class Admin::SessionsController < ApplicationController
    def new
    end

    def create
      if email = request.env["omniauth.auth"]["info"]["email"]
        @user = User.find_by(mail: email)
      else
        @user = User.find_by(mail: params[:mail])
        unless @user && BCrypt::Password.new(@user.password_digest) == params[:password]
          flash[:alert] = "メールアドレスかパスワードが間違っています"
          return render :new, status: :unauthorized
        end
      end
      session[:current_user_id] = @user.id
      redirect_to admin_users_path
    end
    

    def destroy
      reset_session
      redirect_to new_admin_session_url, status: :see_other
    end

end