class SearchesController < ApplicationController

  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    if model == "room"
      Room.where('room_name LIKE ?', '%'+content+'%')
    elsif model == "novel"
      Novel.where('title LIKE ?', '%'+content+'%')
    elsif  model == "room_tag"
      RoomTag.where('tag_name LIKE ?', '%'+content+'%')
    elsif model == "novel_tag"
      NovelTag.where('tag_name LIKE ?', '%'+content+'%')
    elsif model == "user"
      User.where('name LIKE ?', '%'+content+'%')
    end
  end


end
