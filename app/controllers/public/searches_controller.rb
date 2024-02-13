class Public::SearchesController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]

    if @range == '1'
      @user = User.search(search, word).page(params[:page])
    else
      @post_sauna = PostSauna.search(search, word).page(params[:page])
    end
  end
end
