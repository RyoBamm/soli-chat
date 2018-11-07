class LikesController < ApplicationController
  before_action :set_post
  before_action :set_likes

  def create
    @like = Like.create(user_id: current_user.id, post_id: params[:post_id])
    @post.reload
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
    @post.reload
  end

  private
  def set_likes
    @likes = Like.where(post_id: params[:post_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
