class PostsController < ApplicationController
  # before_action :set_new_post, only: [:create]

  def index
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
end
