class LikesController < ApplicationController
  before_action :set_likes, only: [:create, :destroy]
  def create
    @like = Like.create(likes_params)
  end

  def destroy
    like = Like.find_by(likes_params)
    like.destroy
  end

  private
  def set_likes
    @likes = Like.where(post_id: params[:post_id])
  def

  def likes_params
    params.require(:like).permit(
      :post_id,
    ).merge(user_id: current_user.id)
  end
end
