class CategoriesController < ApplicationController
  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categoryParams)
    # @category.user_id = current_user.id
    if @category.save!
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
end
