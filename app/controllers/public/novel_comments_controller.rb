class Public::NovelCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.novel_comments.new(comment_params)
    @comment.novel_id = params['novel_id']
    @novel = @comment.novel
    visited_id = @novel.user_id
    if @comment.save
      @novel.save_notification_novelcomment(current_user,@comment.id,visited_id )
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = NovelComment.find(params[:id])
    @comment.destroy
    @novel = @comment.novel
  end

  private

  def comment_params
    params.require(:novel_comment).permit(:comment)
  end

end
