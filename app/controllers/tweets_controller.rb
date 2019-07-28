class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :update]

  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(content: params[:tweet][:content])
    if params[:back]
      render 'new'
    else
      if @tweet.save
        # 一覧画面へ遷移して"投稿を完了しました！"とメッセージを表示します。
        redirect_to tweets_path, notice: "投稿を完了しました！"
      else
        # 投稿画面を再描画します。
        render 'new'
      end
    end
  end

  def confirm
    @tweet = Tweet.new(content: params[:tweet][:content])
    render :new if @tweet.invalid?
  end

  def update
    # 編集した内容をセット
    @tweet.content = params[:tweet][:content]
    if @tweet.invalid?
      render 'edit'
    else
      if @tweet.update(content: params[:tweet][:content])
        redirect_to tweets_path, notice: "投稿を編集しました！"
      else
        render 'edit'
      end
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
