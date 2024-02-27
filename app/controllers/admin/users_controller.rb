class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])

  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @departments = Department.all
    @skills = Skill.all
  end

  def create
    @user = User.new(user_params)
    @user.department = Department.find(params[:user][:department_id]) if params[:user][:department_id].present?
    @user.skills = Skill.find(params[:user][:skill_ids]) if params[:user][:skill_ids].present?
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
    @user.department = Department.find(params[:user][:department_id]) if params[:user][:department_id].present?
    @user.skills = Skill.find(params[:user][:skill_ids]) if params[:user][:skill_ids].present?
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
      params.require(:user).permit(:name,:hiragana_nama,:sex,:tel,:mobile,:mail,:postcode,:address1,:address2,:address3,:address4,:address5,:birthday)
    end
end
