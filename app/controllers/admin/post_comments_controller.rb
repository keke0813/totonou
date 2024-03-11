class Admin::PostCommentsController < ApplicationController

  #権限設定
  before_action :authenticate_admin!

  def destroy
    post_sauna = PostSauna.find(params[:post_sauna_id])
    @comment = PostComment.find(params[:id]).destroy
    @comment.destroy
    #redirect_to post_sauna_path(params[:post_sauna_id])
  end

end
