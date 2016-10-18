class TopController < ApplicationController
  before_action :require_sign_in, only: %i(index)

  def index
    @posts = Post.all
  end
end
