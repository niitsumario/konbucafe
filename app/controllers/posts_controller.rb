class PostsController < ApplicationController

  def index
    @post_new = Post.new
    #@post_new.build_spot
    @posts = Post.all.order(created_at: :desc)
  end

  def create
    @post_new = Post.new(post_params)
    @post_new.user_id = current_user.id
    @post_new.save
    redirect_to posts_path
  end

  def show
    @post_new = Post.new
    @post = Post.find(params[:id])
    #@lat = @post.spot.latitude
    #@lng = @post.spot.longitude
    #gon.lat = @lat
    #gon.lng = @lng
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path
    else
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :shop_name, :introduction)#, spot_attributes: [:address])
  end

end
