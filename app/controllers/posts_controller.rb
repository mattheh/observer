class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @post = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create(post_params)

    @user.save
    redirect_to user_posts_path, method: :get
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to user_posts_path, method: :get
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to user_posts_path, method: :get
  end

  def toggle
    @post = Post.find(params[:id])
    @post.active = !@post.active
    @post.save
    redirect_to user_posts_path, method: :get
  end

  private

  def post_params
    params.require(:post).permit(:title, :price, :category, :location, :url, :active)
  end
end
