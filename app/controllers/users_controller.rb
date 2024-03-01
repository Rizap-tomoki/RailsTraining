class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(params[:per_page])
    @users = @users.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
    @users = @users.where(address1: params[:address1]) if params[:address1].present?
    @users = @users.order(birthday: params[:birthday]) if params[:birthday].present?
  end
  
  def show
    @user = User.find(params[:id])
  end
end
  