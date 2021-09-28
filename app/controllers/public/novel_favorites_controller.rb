class Public::NovelFavoritesController < ApplicationController

  def create
    @room = Room.find(params[:room_id])
    @novel = Novel.find(params[:novel_id])
    @favorite = current_user.novel_favorites.new(novel_id: params[:novel_id])
    @favorite.save
    @favorite.create_notification_novelfavorite(current_user)
  end

  def destroy
    @room = Room.find(params[:room_id])
    @novel = Novel.find(params[:novel_id])
    favorite = current_user.novel_favorites.find_by(novel_id: params[:novel_id])
    favorite.destroy
  end

end
