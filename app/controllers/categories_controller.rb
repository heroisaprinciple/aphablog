class CategoriesController < ApplicationController
  before_action :require_admin, except: [:index, :show]
  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categoryParams)
    binding.break
    # @category.user_id = current_user.id
    if @category.save
      binding.break
      flash[:notice] = 'A new category is created.'
      redirect_to @category

    else
      flash[:alert] = 'A new category is NOT created. Try again.'
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  private
  def categoryParams
    params.require(:category).permit(:name)
  end

  def require_admin
    unless logged_in? && current_user.admin
      flash[:alert] = 'Only admins are allowed to do that.'
      redirect_to categories_path
    end
  end
end
