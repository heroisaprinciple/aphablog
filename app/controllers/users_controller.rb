class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(userPermit)
    if @user.save!
      binding.break
      flash['notice'] = "Welcome to the blog, #{@user.username}."
      redirect_to articles_path

    else
      binding.break
      render :new
    end

  end

  def show

  end

  private
  def userPermit
    params.require(:user).permit(:username, :email, :password)
  end

end
