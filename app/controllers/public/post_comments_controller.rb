class Public::PostCommentsController < ApplicationController

  #権限設定
  before_action :authenticate_user!

  def create
    post_sauna = PostSauna.find(params[:post_sauna_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.score = Language.get_data(post_comment_params[:comment])
    @comment.post_sauna_id = post_sauna.id
    @comment.save
    #redirect_to post_sauna_path(post_sauna)
  end

  def destroy
    post_sauna = PostSauna.find(params[:post_sauna_id])
    @comment = PostComment.find(params[:id]).destroy
    @comment.destroy
    #redirect_to post_sauna_path(params[:post_sauna_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
