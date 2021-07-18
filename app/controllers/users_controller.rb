class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @post_new = Post.new
    @post_new.build_spot
    @posts = @user.posts.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(@user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def likes
    @post_new = Post.new
    @post_new.build_spot
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id).page(params[:page]).per(5)
  end

  #————————フォロー・フォロワー一覧を表示する-————————————
  def following
    @post_new = Post.new
    @post_new.build_spot
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'follow'
  end

  def followers
    @post_new = Post.new
    @post_new.build_spot
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'follower'
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end

end
