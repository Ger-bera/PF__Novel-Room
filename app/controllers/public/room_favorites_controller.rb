class Public::RoomFavoritesController < ApplicationController

  def create
    @favorite = current_user.room_favorites.new(room_id: params[:room_id])
    @favorite.save
    @favorite.create_notification_roomfavorite(current_user)
    redirect_to room_path(params[:room_id])
  end

  def destroy
    favorite = current_user.room_favorites.find_by(room_id: params[:room_id])
    favorite.destroy
    redirect_to room_path(params[:room_id])
  end

end
