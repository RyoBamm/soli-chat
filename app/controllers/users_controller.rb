class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    redirect_to :root unless user_signed_in? && @user.id == current_user.id
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
