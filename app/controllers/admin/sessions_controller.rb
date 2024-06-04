class Admin::SessionsController < ApplicationController
    def new
    end

    def create
      @user = User.find_by(mail: params[:mail])
      if @user && BCrypt::Password.new(@user.password_digest) == params[:password]
        session[:current_user_id] = @user.id
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

    def google
      email = request.env["omniauth.auth"]["info"]["email"]
      if email.end_with?("@rizapgroup.com")
        @user = User.find_by(mail: email)
  
        if @user.present?
          flash[:notice] = "Google認証でログインしました。"
          session[:current_user_id] = @user.id
          redirect_to admin_users_path
        else
          flash[:alert] = "Google認証に失敗しました。ユーザーが登録されていません。"
          redirect_to new_admin_session_path, status: :unauthorized
        end
      else
        flash[:alert] = "Google認証に失敗しました。RIZAPグループのメールアドレスのみが認証されます。"
        redirect_to new_admin_session_path, status: :unauthorized
      end
    end
end