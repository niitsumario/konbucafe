class BlogsController < ApplicationController
  def index
    @user = User.find(current_user.id)
    @blog = Blog.new
    @blogs = @user.blogs
  end

  def create
    @blog = Blog.new(blog_parameter)
    @blog.user_id = current_user.id
    @blog.save
    redirect_to blogs_path
  end

  def show
    @blog = Blog.find(params[:id])
    if @blog.user != current_user
      redirect_to posts_path
    end
  end

  def edit
    @blog = Blog.find(params[:id])
    if @blog.user != current_user
      redirect_to posts_path
    end
  end

  def update
    @blog = Blog.find(params[:id])
    @blog.user_id = current_user.id
    if @blog.update(blog_parameter)
      redirect_to blogs_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.user_id = current_user.id
    @blog.destroy
    redirect_to blogs_path, notice:"削除しました"
  end

  private

  def blog_parameter
    params.require(:blog).permit(:title, :content, :start_time)
  end
end
