class TweetsController < ApplicationController

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)

    @tweet.shortened = RubyLLM.chat.ask("Generate a tweet from this text: #{@tweet.long}").content
    if @tweet.save
      redirect_to tweet_path(@tweet)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end


  private
  def tweet_params
    params.require(:tweet).permit(:long)
  end
end
