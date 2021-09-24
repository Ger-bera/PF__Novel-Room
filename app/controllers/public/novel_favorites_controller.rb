class Public::NovelFavoritesController < ApplicationController

  def create
    @room = Room.find(params[:room_id])
    favorite = current_user.novel_favorites.new(novel_id: params[:novel_id])
    favorite.save
    favorite.create_notification_novelfavorite(current_user)
    redirect_to room_novel_path(params[:room_id],params[:novel_id])
  end

  def destroy
    favorite = current_user.novel_favorites.find_by(novel_id: params[:novel_id])
    favorite.destroy
    redirect_to room_novel_path(params[:room_id],params[:novel_id])
  end

end
