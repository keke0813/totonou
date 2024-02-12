class Public::FavoritesController < ApplicationController

  #権限設定
  before_action :authenticate_user!

  def create
    post_sauna = PostSauna.find(params[:post_sauna_id])
    favorite = current_user.favorites.new(post_sauna_id: post_sauna.id)
    favorite.save
    redirect_to post_sauna_path(post_sauna)
  end

  def destroy
    post_sauna = PostSauna.find(params[:post_sauna_id])
    favorite = current_user.favorites.find_by(post_sauna_id: post_sauna.id)
    favorite.destroy
    redirect_to post_sauna_path(post_sauna)
  end

end
