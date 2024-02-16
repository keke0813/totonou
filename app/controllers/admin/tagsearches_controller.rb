class Admin::TagsearchesController < ApplicationController

  #権限設定
  before_action :authenticate_admin!

  def search
    @word = params[:content]
    @post_saunas = PostSauna.where("category LIKE?","%#{@word}%").page(params[:page])
    render "admin/tagsearches/tagsearch"
  end
end
