class UsersController < ApplicationController

  def index
    @user = User.all
  end
  def new
    @user = User.new
  end

  def show
    findParams

    @articles = @user.articles # to show particular articles, connected to the user
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
    findParams
  end

  def update
    findParams

    binding.break
    if @user.update(userPermit)
      binding.break
      flash['notice'] = "Your profile is successfully updated, #{@user.username}"
      redirect_to user_path(@user) # the same as @user

    else
      render :edit
    end
  end

  private

  def findParams
    @user = User.find(params[:id])
  end
  def userPermit
    params.require(:user).permit(:username, :email, :password)
  end

end
