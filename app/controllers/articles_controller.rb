class ArticlesController < ApplicationController
  def index
    @article = Article.all
  end
  def show
    @article = Article.find(params[:id]) # thus, we can access a concrete article
    # like '.../articles/2' in URL, params is params, but also hashed, so id would be returned
    # in the hash format
  end

  def new
    # creating a new article
  end

  def create
    # displaying this article

    # when creating a new article, nothing might happen and a new article is not saved.
    # this is because we don't render it in `create` method in Articles controller.
    # by using render plain: params[:article], we'll specify what is going to be rendered: a new article.
    # so, on '/articles', a new article will be returned: {"title"=>"eweqweqwe", "description"=>"qweqeqweqwewqe"}
    # but, it only renders by the browser, the new article is NOT saved yet.
    render plain: params[:article]
  end
end
