class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @tags = Tag.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      input_tags = tag_params.split(' ')
      @article.create_tag(input_tags)
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    @tag = @article.tags.pluck(:name).join(' ')
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      input_tags = tag_params.split(' ')
      @article.update_tags(input_tags)
      redirect_to @article
    else
      redirect_to request.referer
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path, notice: "Todo was successfully deleted.", status: :see_other
  end

  private

  def article_params
    params.expect(article: [:title, :about, :body])
  end

  def tag_params
    params.expect(article: [:name])[:name]
  end
end
