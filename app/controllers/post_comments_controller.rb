class PostCommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_back(fallback_location: posts_path)
    else
      @post_new = Post.new
      @post = post
      @post_comment = PostComment.new
      @post_tags = @post.tags
      @lat = @post.spot.latitude #地図表示
      @lng = @post.spot.longitude #地図表示
      redirect_to post_path(@post)
    end
  end

  def destroy
    PostComment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_back(fallback_location: posts_path)
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
