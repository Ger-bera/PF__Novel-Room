class Public::HomesController < ApplicationController
  def top
    @all_novelranks = Novel.find(NovelFavorite.group(:novel_id).order('count(novel_id) desc').limit(3).pluck(:novel_id))
    @all_roomranks = Room.find(RoomFavorite.group(:room_id).order('count(room_id) desc').limit(3).pluck(:room_id))
  end

  def about
  end
end
