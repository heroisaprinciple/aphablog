class UsersController < ApplicationController
  def index
    @user = User.all
  end
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(userPermit)
    if @user.save!
      flash['notice'] = "Welcome to the blog, #{@user.username}."
      redirect_to articles_path

    else
      render :new
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    binding.break
    if @user.save!
      binding.break
      flash['notice'] = "Your profile is successfully updated, #{@user.username}"
      redirect_to articles_path

    else
      render :edit
    end
  end

  private
  def userPermit
    params.require(:user).permit(:username, :email, :password)
  end

end
