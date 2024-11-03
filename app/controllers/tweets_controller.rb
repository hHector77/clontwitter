class TweetsController < ApplicationController
  def show
    @tweet = Tweet.find_by(id: params[:id])
  end

  def index
    if params[:search]
      @tweets = Tweet.where("description LIKE ?", "%#{params[:search]}%").page(params[:page]).per(10)
    else
      @tweets = Tweet.page(params[:page]).per(10)
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to @tweet, notice: 'Tweet creado exitosamente.'
    else
      render :new
    end
  end

  def edit
    @tweet = Tweet.find_by(id: params[:id])
  end

  def update
    @tweet = Tweet.find_by(id: params[:id])
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: 'Tweet actualizado exitosamente.'
    else
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find_by(id: params[:id])
    @tweet.destroy
    redirect_to tweets_url, notice: 'Tweet eliminado exitosamente.'
  end

  private

  def tweet_params
    params.require(:tweet).permit(:description, :username)
  end
end
