class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(content: params[:tweet][:content])
    if params[:back]
      render :new
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
end
