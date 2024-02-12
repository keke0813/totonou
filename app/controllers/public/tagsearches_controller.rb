class Public::TagsearchesController < ApplicationController
  def search
    @word = params[:content]
    @post_sauna = PostSauna.where("category LIKE?","%#{@word}%")
    render "public/tagsearches/tagsearch"
  end
end
