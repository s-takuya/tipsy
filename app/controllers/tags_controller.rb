class TagsController < ApplicationController
  def index
    @tags = Tag.all.includes(:posts)
  end

  def show
    @tag = Tag.find_by_name!(params[:name])
    @posts = @tag.posts
  end
end
