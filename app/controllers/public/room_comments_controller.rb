class Public::RoomCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
     @comment = current_user.room_comments.new(comment_params)
     @comment.room_id = params['room_id']
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = RoomComment.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  private
  def comment_params
    params.require(:room_comment).permit(:comment)
  end

end
