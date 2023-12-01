class UsersController < ApplicationController
  def index
    @users=User.all
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
    if @user.save
      redirect_to @user
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
    if @user.update(user_params)
      redirect_to @user
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
      params.require(:user).permit(:name,:hiragana_nama,:sex,:tel,:mobile,:mail,:postcode,:address1,:address2,:address3,:address4,:address5,:birthday,:department_id,skill_ids:[])
    end
end

