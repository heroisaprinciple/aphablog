class ArticlesController < ApplicationController
  def show

  end
  def index
    @article = Article.find(params[:id]) # thus, we can access a concrete article
    # like '.../articles/2' in URL, params is params, but also hashed, so id would be returned
    # in the hash format
  end
end
