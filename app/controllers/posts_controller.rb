class PostsController < ApplicationController

  def index
    @post_new = Post.new
    @post_new.build_spot #地図投稿機能
    @tags = Tag.all #全てのタグ
    @posts = Post.all.order(created_at: :desc)
  end

  def create
    @post_new = Post.new(post_params)
    @post_new.user_id = current_user.id
    tag_list = params[:post][:tag_name].split(",") #タグをpostと一緒にcreateできるようにする
    if @post_new.save
      @post_new.save_tag(tag_list)
      redirect_to posts_path, notice: '投稿しました！'
    else
      @post_new = @post_new
      @post_new.build_spot #地図投稿機能
      @tags = Tag.all
      @posts = Post.all.order(created_at: :desc)
      render :index
    end
  end

  def show
    @post_new = Post.new
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_tags = @post.tags
    @lat = @post.spot.latitude #地図表示
    @lng = @post.spot.longitude #地図表示
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(",")
    @lat = @post.spot.latitude
    @lng = @post.spot.longitude
    if @post.user != current_user
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(",")
    if @post.update(post_params)
      @post.save_tag(tag_list)
      redirect_to post_path(@post.id), notice: '投稿を編集しました！'
    else
      @post = @post
      @tag_list = @post.tags.pluck(:tag_name).join(",")
      @lat = @post.spot.latitude
      @lng = @post.spot.longitude
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to posts_path, notice: '投稿を削除しました'
    else
      render :show
    end
  end

  #いいねが多い順に表示
  def ranks
    @post_new = Post.new
    @post_new.build_spot
    @all_ranks = Post.includes(:liked_users).sort {|a,b| b.liked_users.size <=> a.liked_users.size}
  end

  #タグに紐付いた全ての投稿
  def taglists
    @tags = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :shop_name, :introduction, spot_attributes: [:address])
  end

end
