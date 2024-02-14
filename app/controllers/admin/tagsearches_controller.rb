class Admin::TagsearchesController < ApplicationController
  def search
    @word = params[:content]
    @post_saunas = PostSauna.where("category LIKE?","%#{@word}%").page(params[:page])
    render "admin/tagsearches/tagsearch"
  end
end
