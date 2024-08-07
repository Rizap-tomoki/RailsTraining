class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def img
    @user = User.find(params[:id])
    send_data @user.image, disposition: 'inline'
  end

  def new
    @user = User.new
    @departments = Department.all
    @skills = Skill.all
  end

  def create
    @user = User.new(user_params)
    if params[:user].present? && params[:user][:image].present?
      params[:user][:image] = params[:user][:image].read.unpack1('H*')
    end
    encrypt_password_digest(@user, params[:user][:password])
    if @user.save
      redirect_to admin_user_path(@user)
    else
      @departments = Department.all
      @skills = Skill.all
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
    @departments = Department.all
    @skills = Skill.all
  end

  def update
    @user = User.find(params[:id])
    if params[:user].present? && params[:user][:image].present?
      params[:user][:image] = params[:user][:image].read.unpack1('H*')
    end
    encrypt_password_digest(@user, params[:user][:password])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      @departments = Department.all
      @skills = Skill.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, status: :see_other
  end

  private
    def user_params
      params.require(:user).permit(:name,:hiragana_nama,:sex,:tel,:mobile,:mail,:password,:password_confirmation,:postcode,:address1,:address2,:address3,:address4,:address5,:birthday,:image,:department_id,skill_ids:[])
    end
    def encrypt_password_digest(user, password)
      user.password_digest = BCrypt::Password.create(password) if password.present?
    end
end
