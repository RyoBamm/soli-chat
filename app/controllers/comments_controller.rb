class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update]

  def show
  end

  def create
    if user_signed_in?
      comment = Comment.includes(:user).create(comment_params)
      respond_to do |format|
        format.html{
          redirect_to post_path(comment.post_id), notice: 'コメントを投稿しました'
        }
        format.js
      end
    else
      redirect_to post_path(@comment.post_id), alert: 'ログインしてください'
    end
  end

  def edit
  end

  def update
    if user_signed_in? && @comment.user_id == current_user.id
      @comment.update( comment: comment_params_for_edit_function[:comment] )
    else
      edirect_to post_path(@comment.post_id), alert: 'コメント投稿に失敗しました'
    end
  end

  def destroy
    comment = Comment.find(comment_params_for_edit_function[:id])
    if user_signed_in? && comment.user_id == current_user.id
      comment.destroy
      redirect_to post_path(comment.post_id), notice: 'コメントを削除しました'
    else
      redirect_to post_path(comment.post_id), aleat: 'コメント削除に失敗しました'
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:id, :comment).merge(user_id: current_user.id).merge(post_id: params[:post_id])
  end

  def comment_params_for_edit_function
    params.permit(:id, :comment)
  end

  def set_comment
    @comment = Comment.includes(:user).find(params[:id])
  end
end
