class Admin::PostSaunasController < ApplicationController

  #権限設定
  before_action :authenticate_admin!

  def index
    @post_saunas = PostSauna.page(params[:page])
  end

  def show
    @post_sauna = PostSauna.find(params[:id])
    @user = @post_sauna.user
  end

  def destroy
    post_sauna = PostSauna.find(params[:id])
    post_sauna.destroy
    flash[:notice] = "削除に成功しました。"
    redirect_to admin_post_saunas_path
  end

end
