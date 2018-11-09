class PostsController < ApplicationController
  before_action :set_post_including_user, only: [:show]
  before_action :set_post, only: [:edit, :update, :destroy]
  # before_action :set_likes, only: [:show]

  def index
  end

  def show
    @likes = Like.where(post_id: params[:post_id])
    @like = Like.find_by(user_id: current_user.id, post_id: params[:id])
    @comments = @post.comments.page(params[:page]).per(5).order("created_at DESC")
    @comment = Comment.new()
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    if user_signed_in? && current_user.id == post.user_id
      if post.save
        redirect_to "/users/#{current_user.id}", notice: '投稿が完了しました'
      else
        redirect_to new_post_path, alert: 'エラーが発生しました'
      end
    else
      redirect_to root_path, alert: 'ログインしてください'
    end
  end

  def edit
  end

  def update
    if user_signed_in? && current_user.id == @post.user_id
      # binding.pry
      if @post.update(post_params)
        redirect_to post_path(@post.id), notice: '投稿を編集しました'
      else
        redirect_to post_path(@post.id), notice: '編集に失敗しました'
      end
    end
  end

  def destroy
    if user_signed_in? && current_user.id == @post.user_id
      if @post.destroy
        redirect_to "/users/#{current_user.id}", notice: '投稿を削除しました'
      else
        redirect_to post_path(post.id), notice: '削除に失敗しました'
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(
      :title,
      :video,
      :youtube,
      :post_type,
      :description,
    ).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_post_including_user
    @post = Post.includes(:user).find(params[:id])
  end

  # def set_likes
  #   @likes = Like.where(post_id: params[:post_id])
  # end
end
