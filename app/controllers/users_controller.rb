class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    redirect_to :root unless user_signed_in? && @user.id == current_user.id

    @posts = @user.posts.page(params[:page]).per(4).order("created_at DESC")
    @user_info = {posts_count: @user.posts.count,all_likes: total_likes_count(@user.id)}
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

# Modelnないため仮置き。ToDo:concern lib化
  def total_likes_count(user_id)
    posts = User.find(user_id).posts
    total_likes_count = 0
    posts.each do |post|
      total_likes_count += post.likes_count
    end
    return total_likes_count
  end
end
