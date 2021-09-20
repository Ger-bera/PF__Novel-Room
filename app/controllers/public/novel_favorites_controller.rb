class Public::NovelFavoritesController < ApplicationController

  def create
    favorite = current_user.novel_favorites.new(novel_id: params[:novel_id])
    favorite.save
    redirect_to room_novel_path(params[:room_id],params[:novel_id])
  end

  def destroy
    favorite = current_user.novel_favorites.find_by(novel_id: params[:novel_id])
    favorite.destroy
    redirect_to room_novel_path(params[:room_id],params[:novel_id])
  end

end
