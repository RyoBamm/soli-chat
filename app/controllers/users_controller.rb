class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    redirect_to :root unless user_signed_in? && @user.id == current_user.id

    @posts = @user.posts.page(params[:page]).per(4).order("created_at DESC")
    @posts_count = @user.posts.count

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
