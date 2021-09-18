class Public::RoomFavoritesController < ApplicationController

  def create
    @room = Room.find(params[:room_id])
    favorite = current_user.room_favorites.new(room_id: @room.id)
    favorite.save
    redirect_to room_path(params[:room_id])
  end

  def destroy
    @room = Room.find(params[:room_id])
    favorite = current_user.room_favorites.find_by(room_id: @room.id)
    favorite.destroy
    redirect_to room_path(params[:room_id])
  end

end
