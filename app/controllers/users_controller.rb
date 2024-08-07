class UsersController < ApplicationController

  def index
    @per_page = params[:per_page]
    @name = params[:name]
    @address1 = params[:address1]
    @order = params[:order]
    @users = User.page(params[:page]).per(@per_page).search_name(@name).search_address1(@address1).order_by(@order)
  end
  
  def show
    @user = User.find(params[:id])
  end

  def sitemap
    @users = User.all
  end

  def user_scripts
    @users = User.all
    respond_to do |format|
      format.html 
      format.json { render json: @users } 
    end
  end

end
  