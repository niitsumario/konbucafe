class PostsController < ApplicationController

  def index
    @post_new = Post.new
    #@post_new.build_spot
    @posts = Post.all
  end

  def create
    @post_new = Post.new(post_params)
    @post_new.user_id = current_user.id
    if @post_new.save
      redirect_to posts_path
    else
      redirect_to :index
    end
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
  end

  def update
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
