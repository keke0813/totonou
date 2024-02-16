class Admin::UsersController < ApplicationController

  #権限設定
  before_action :authenticate_admin!

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
        redirect_to admin_user_path(@user)
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
    params.require(:user).permit(:profile_image, :name, :introduction, :favorite_drink_image, :favorite_drink, :is_active)
  end

end
