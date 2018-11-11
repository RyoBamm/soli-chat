class PostsController < ApplicationController
  before_action :set_post_including_user, only: [:show]
  before_action :set_post, only: [:edit, :update, :destroy]
  # before_action :set_likes, only: [:show]

  def index
    @all_posts = Post.includes(:categories).page(params[:page]).per(8).order("created_at DESC")
    @recommended_posts = Post.order('likes_count DESC').limit(10)
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
    @post = Post.includes(:post_categories).new
  end

  def create
    post = Post.new(post_params)
    if user_signed_in? && current_user.id == post.user_id
      if post.save
        params[:post][:category_ids].each do |category_id|
          PostCategory.create(category_id: category_id, post_id: post.id)
        end
        redirect_to "/posts/#{post.id}", notice: '投稿が完了しました'
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
      if @post.update(post_params)
        if @post.post_categories
          @post.post_categories.each do |post_category|
            deleting_post_category = PostCategory.find(post_category.id)
            deleting_post_category.destroy
          end
        end
        params[:post][:category_ids].each do |category_id|
          PostCategory.create(category_id: category_id, post_id: @post.id)
        end
        redirect_to post_path(@post.id), notice: '投稿を編集しました'
      else
        redirect_to post_path(@post.id), notice: '編集に失敗しました'
      end
    end
  end

  def destroy
    if user_signed_in? && current_user.id == @post.user_id
      if @post.destroy
        redirect_to "/users/#{current_user.id}"
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
    @post = Post.includes([:user, :categories]).find(params[:id])
  end

  # def set_likes
  #   @likes = Like.where(post_id: params[:post_id])
  # end
end
