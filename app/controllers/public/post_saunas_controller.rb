class Public::PostSaunasController < ApplicationController

  #権限設定
  before_action :authenticate_user!

  def new
    @post_sauna = PostSauna.new
  end

  def create
    @post_sauna = PostSauna.new(post_sauna_params)
    @post_sauna.user_id = current_user.id
    if @post_sauna.save
      redirect_to post_sauna_path(@post_sauna)
    else
      render :new
    end
  end

  def index
    @post_saunas = PostSauna.page(params[:page])
  end

  def show
    @post_sauna = PostSauna.find(params[:id])
    @post_comment = PostComment.new
    @user = @post_sauna.user
  end

  def edit
    @post_sauna = PostSauna.find(params[:id])
  end

  def update
    @post_sauna = PostSauna.find(params[:id])
    if @post_sauna.update(post_sauna_params)
      redirect_to post_sauna_path(@post_sauna)
    else
      render :edit
    end
  end

  def destroy
    post_sauna = PostSauna.find(params[:id])
    post_sauna.destroy
    redirect_to post_saunas_path
  end

  private

  def post_sauna_params
    params.require(:post_sauna).permit(:image, :name, :address, :price, :impression, :category, :star)
  end
end
