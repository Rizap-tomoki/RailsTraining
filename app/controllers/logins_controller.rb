class LoginsController < ApplicationController
    def new
    end

    def create
      if user = User.find_by(mail: params[:session][:mail].downcase)
        session[:current_user_id] = user.id
        redirect_to admin_users_path, status: :see_other
      else
        flash[:alert] = "メールアドレスが間違っています"
        render :new, status: :unauthorized
      end
    end

    def destroy
      session.delete(:current_user_id)
      @_current_user = nil
      redirect_to users_url, status: :see_other
    end
end