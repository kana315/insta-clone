class UsersController < ApplicationController
  before_action :no_logged_in, only: [:favorites]
  before_action :set_user, only: [:show, :edit, :update, :favorites, :posts]
  before_action :set_favorites, only: [:show, :favorites]
  before_action :set_post, only: [:show, :posts]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user.id)
    flash[:notice] = 'プロフィール編集しました'
  end

  def posts
  end

  def favorites
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :icon, :icon_cache)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def set_favorites
    @favorites = Favorite.where(user_id: @user.id)
  end

  def set_post
    @post = Post.where(user_id: params[:id])
  end

  def no_logged_in
    unless current_user.present?
      redirect_to new_session_path
    end
  end
end
