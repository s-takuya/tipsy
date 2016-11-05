class UsersController < ApplicationController
  before_action :require_sign_in

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end
end
