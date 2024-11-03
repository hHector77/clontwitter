class TweetsController < ApplicationController
  def index
    if params[:search]
      @tweets = Tweet.where("description LIKE ?", "%#{params[:search]}%").page(params[:page]).per(10)
    else
      @tweets = Tweet.page(params[:page]).per(10)
    end
  end
end
