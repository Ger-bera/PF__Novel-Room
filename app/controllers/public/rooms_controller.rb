class Public::RoomsController < ApplicationController

  def new
    @room = Room.new
  end

  def index
    if params[:search].present? #検索欄にワードが存在するか？
      rooms = Room.novelss_serach(params[:search])
    elsif params[:tag_id].present?
      @tag = RoomTag.find(params[:tag_id])
      rooms = @tag.rooms.order(created_at: :desc)
    else
      rooms = Room.all.order(created_at: :desc)
    end
    @tag_lists = RoomTag.all
    @rooms = Kaminari.paginate_array(rooms).page(params[:page]).per(10)
  end

  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(room_params)
    tag_list = params[:room][:tag_name].split
    @room.user_id = current_user.id
    if @room.save
       @room.save_rooms(tag_list)
      redirect_to rooms_path
    else
      flash.now[:alert] = "作成に失敗しました"
      render "new"
    end
  end

  def edit
    @room = Room.find(params[:id])
    if @room.user == current_user
      render "edit"
    else
      redirect_to rooms_path
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room.id)
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
  end

  private

  def room_params
    params.require(:room).permit(:room_name, :world_body)
  end

end
