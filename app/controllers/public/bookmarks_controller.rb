class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @novel = Novel.find(params[:novel_id])
    bookmark = @novel.bookmarks.new(user_id: current_user.id)
    if bookmark.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

  def destroy
    @novel = Novel.find(params[:novel_id])
    bookmark = @novel.bookmarks.find_by(user_id: current_user.id)
    if bookmark.present?
      bookmark.destroy
      redirect_to request.referer
    else
      redirect_to request.referer
    end
  end

end
