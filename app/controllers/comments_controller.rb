class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update]
  before_action :set_post_including_user, only: [:create]

  def show
  end

  def create
    if user_signed_in?
      comment = Comment.includes(:user).create(comment_params)
      @comments = @post.comments.page(params[:page]).per(5).order("created_at DESC")
      @comment = Comment.new()
    else
      redirect_to new_user_session_path
    end
  end

  def edit
  end

  def update
    if user_signed_in? && @comment.user_id == current_user.id
      @comment.update( content: comment_params[:content] )
    end
  end

  def destroy
    comment = Comment.find(comment_params[:id])
    if user_signed_in? && comment.user_id == current_user.id
      comment.destroy
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:id, :comment).merge(user_id: current_user.id).merge(post_id: params[:post_id])
  end

  def set_comment
    @comment = Comment.includes(:user).find(comment_params[:id])
  end

  def set_post_including_user
    @post = Post.includes(:user).find(params[:post_id])
  end
end
