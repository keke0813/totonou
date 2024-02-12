class Public::UsersController < ApplicationController

  #権限設定
  before_action :authenticate_user!

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @post_saunas = @user.post_saunas.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction, :favorite_drink_image, :favorite_drink)
  end

end
