class Public::TagsearchesController < ApplicationController
  def search
    @word = params[:content]
    @post_saunas = PostSauna.where("category LIKE?","%#{@word}%").page(params[:page])
    render "public/tagsearches/tagsearch"
  end
end
