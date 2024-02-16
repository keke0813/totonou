class Public::TagsearchesController < ApplicationController

  #権限設定
  before_action :authenticate_user!

  def search
    @word = params[:content]
    @post_saunas = PostSauna.where("category LIKE?","%#{@word}%").page(params[:page])
    render "public/tagsearches/tagsearch"
  end
end
