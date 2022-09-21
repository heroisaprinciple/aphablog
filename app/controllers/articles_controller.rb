class ArticlesController < ApplicationController
  # means do before the particular action
  before_action :findArticle, only: [:show, :edit, :update, :destroy]

  def index
    # @article = Article.all
    @article = Article.paginate(page: params[:page], per_page: 10)
  end
  def show
    # @article = Article.find(params[:id])
    # thus, we can access a concrete article
    # like '.../articles/2' in URL, params is params, but also hashed, so id would be returned
    # in the hash format
  end

  def new
    # creating a new article

    # thus, we'll save the page from erroring NilClass when saving @article in db
    @article = Article.new
  end

  def edit
    # binding.break # to debug, look in the console, then use `params`, then `continue` in debug console
    # @article = Article.find(params[:id])
  end

  def create
    binding.break
    # displaying this article

    # when creating a new article, nothing might happen and a new article is not saved.
    # this is because we don't render it in `create` method in Articles controller.
    # by using render plain: params[:article], we'll specify what is going to be rendered: a new article.
    # so, on '/articles', a new article will be returned: {"title"=>"eweqweqwe", "description"=>"qweqeqweqwewqe"}
    # but, it only renders by the browser, the new article is NOT saved yet.

    # render plain: params[:article]

    # to save to db; :article is our db model
    # to redirect to /articles/id, use `rails routes --expanded`, find /articles/:id URI and method GET
    # PREFIX here is to access: article (which is a prefix)_path (which means path)
    # rails will
    # extract `id` from `@article` class instance.
    @article = Article.new(articleParams)
    binding.break
    # we'll set to a logged in user our article_id
    @article.user_id = current_user.id
    binding.break
    if @article.save!
      binding.break
      flash[:notice] = 'Article is created successfully.' # notice is the key
      redirect_to @article

    else
      # rendering form again: 'new' template
      # @article is available to 'new' template.
      # if you encounter 'NilClass problem', look:
      # the problem is, there is no @article on '/article/new', so we'll create
      # a new @article (which is empty) for the first time to prevent page from erroring:
      # look at new method
      render :new
    end

    puts @article

  end

  def update
    # binding.break
    # @article = Article.find(params[:id])
    if @article.update(articleParams)
      flash['notice'] = 'An article was updated successfully.'
      redirect_to @article

    else
      render :edit

    end
  end

  def destroy
    # binding.break
    # @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, status: :see_other # '/articles' page

  end

  # private # means that the module is only available to that controller
  def findArticle
    @article = Article.find(params[:id])
  end

  def articleParams
    params.require(:article).permit(:id, :title, :description)
  end

end
