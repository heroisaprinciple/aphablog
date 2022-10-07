class SessionsController < ApplicationController
  def new

  end

  def create
    #binding.break
    # notice that user, not @user, because instance var (person) is already existing, but we just need to log in
    user = User.find_by(email: params[:email])
    binding.break
    if user.present? && user.authenticate(params[:password])
      #binding.break
      session[:user_id] = user.id
      binding.break
      redirect_to user_path(user)

    else
      flash[:alert] = 'Either email or password are wrong.'
      render 'new'

    end
  end

  def destroy
    session[:user_id] = nil
    flash['notice'] = 'You are logged out.'
    redirect_to articles_path, status: :see_other
  end

end
