class ArticlesController < ApplicationController
  before_filter :set_article, only: [:show, :edit, :update]

  def index
    @articles = Article.includes(:category).paginate(:page => params[:page])
  end

  def search
    @articles = Article.includes(:category).search(search_params).paginate(:page => params[:page])
    if request.xhr?
      render partial: "table", layout: false
    else
      render "index"
    end
  end

  def top10
    @articles = Article.includes(:category).order("rating DESC").limit(10)
    render "index"
  end

  def neighbors
    @articles = Article.includes(:category).neighbors.order("ip ASC").paginate(:page => params[:page])
    render "index"
  end

  def show
  end

  def edit
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    saved = @article.save
    respond_to do |format|
      if saved
        flash[:success] = t("flash.saved")
        format.html{ redirect_to @article }
      else
        flash[:error] = t("flash.not_saved")
        format.html{ render :new }
      end
      format.js do
        render json: {object: @article, errors: @article.errors, flash: saved ? t("flash.saved") : t("flash.not_saved")}
      end
    end
  end

  def update
    begin
      updated = @article.update(article_params)
      if updated
        flash.now[:success] = t("flash.updated")
      else
        flash.now[:error] = t("flash.not_updated")
      end
    rescue ActiveRecord::StaleObjectError
      flash.now[:error] = t('flash.locked')
    end
    respond_to do |format|
      if updated
        format.html{ redirect_to @article }
      else
        format.html{ render :edit }
      end
      format.js do
        render json: {object: @article, errors: @article.errors, flash: Hash[flash]}
      end
    end
  end

private

  def article_params
    params.require(:article).permit(:title, :content, :category_title, :date, :author, :lock_version).tap do |article|
      article[:ip] = request.remote_ip
    end
  end

  def search_params
    params.require(:search).permit(:category_title, :rating_from, :rating_to, :author, :count_comments, :date)
  end

  def set_article
    @article = Article.find(params[:id])
  end

end
