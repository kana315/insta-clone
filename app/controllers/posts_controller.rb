class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :no_logged_in, only: [:new, :show]

  def new
    if params[:back]
      @post = Post.new(post_params)
      @post.image.retrieve_from_cache! params[:cache][:image]
    else
      @post = Post.new
    end
  end

  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    render "new" if @post.invalid?
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.image.retrieve_from_cache! params[:cache][:image]
    if @post.save
      NoticeMailer.notice_mail(@post).deliver
      flash[:notice] = '投稿しました'
      redirect_to posts_path
    else
      flash.now[:danger] = '投稿に失敗しました'
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def edit
  end

  def destroy
    @post.destroy
    redirect_to posts_path
    flash[:notice] = '投稿を削除しました'
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
      flash[:notice] = '投稿内容を編集しました'
    else
      render 'new'
    end
  end

  def top
  end

  private
  def post_params
    params.require(:post).permit(:image, :caption, :image_cache)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def no_logged_in
    unless current_user.present?
      redirect_to new_session_path
    end
  end
end
