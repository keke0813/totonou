class Admin::PostCommentsController < ApplicationController

  #権限設定
  before_action :authenticate_admin!

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_sauna_path(params[:post_sauna_id])
  end

end
