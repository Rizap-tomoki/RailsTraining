class UsersController < ApplicationController
  def index
    @users = User.all
    @users = @users.where("name LIKE ?", "%#{params[:user_name_search]}%") if params[:user_name_search].present?
    @users = @users.where(address1: params[:user_address1_search]) if params[:user_address1_search].present?
    @users = @users.order(birthday: :desc) if params[:birthday_sort] == "latest"
    @users = @users.order(birthday: :asc) if params[:birthday_sort] == "oldest"
    @users = @users.page(params[:page]).per(params[:per_page])
  end
  
  def show
    @user = User.find(params[:id])
  end
end
  