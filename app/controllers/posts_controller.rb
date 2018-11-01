class PostsController < ApplicationController
  before_action :set_new_post, only: [:new]

  def index
  end

  def new
  end

  def create
    redirect_to "/users/#{current_user.id}"
  end

  private
  def set_new_post
    @post = Post.new
  end
end
