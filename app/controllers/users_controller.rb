class UsersController < ApplicationController

  def index
    #@user = User.all

    @user = User.paginate(page: params[:page], per_page: 10)
  end
  def new
    @user = User.new
  end

  def show
    findParams

    @article = @user.articles.paginate(page: params[:page], per_page: 10) # to show particular articles, connected to the user
  end

  def create
    @user = User.new(userPermit)
    binding.break
    if @user.save!
      session[:user_id] = @user.id
      binding.break
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

  def destroy
    findParams
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = 'Account is successfully deleted!'
    redirect_to users_path
  end

  def findParams
    @user = User.find(params[:id])
  end
  def userPermit
    params.require(:user).permit(:username, :email, :password)
  end

end
