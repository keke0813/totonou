class Public::UsersController < ApplicationController

  #権限設定
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

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

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.guest_user?
      redirect_to user_path(current_user), notice: "ゲストユーザーはユーザー情報編集画面へ遷移できません"
    end
  end

end
