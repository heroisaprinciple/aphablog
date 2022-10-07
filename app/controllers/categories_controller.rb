class CategoriesController < ApplicationController
  def index
    @category = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categoryParams)
    @category.user_id = current_user.id
    if @category.save!
      flash[:notice] = 'Yoiii'
      redirect_to @category

    else
      flash[:alert] = 'no'
      render :new
    end
  end

  def show

  end

  private
  def categoryParams
    params.require(:category).permit(:name)
  end
end
