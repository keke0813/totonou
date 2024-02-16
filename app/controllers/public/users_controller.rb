class Public::UsersController < ApplicationController

  #権限設定
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  before_action :is_matching_login_user, only: [:edit, :update]

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
      if @user.update(user_params)
        flash[:notice] = "編集に成功しました。"
        redirect_to user_path(@user)
      else
        flash.now[:alert] = "編集に失敗しました。"
        render :edit
      end
  end

  def liked_post_saunas
    @user = User.find(params[:id])
    @liked_post_saunas = PostSauna.liked_post_saunas(@user).page(params[:page])
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

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_saunas_path
    end
  end

end
