class Admin::PostSaunasController < ApplicationController

  #権限設定
  before_action :authenticate_admin!

  def index
    @post_saunas = PostSauna.page(params[:page])
  end

  def show
    def show
      @post_sauna = PostSauna.find(params[:id])
      @user = @post_sauna.user
    end
  end

  def destroy
    post_sauna = PostSauna.find(params[:id])
    post_sauna.destroy
    redirect_to admin_post_saunas_path
  end

end
