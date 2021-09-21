class Public::NovelsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def new
    @novel = Novel.new
    @room = Room.find(params[:room_id])
  end

  def index
    if params[:search].present? #検索欄にワードが存在するか？
      novels = Novel.novels_search(params[:search])
    elsif params[:tag_id].present?
      @tag = NovelTag.find(params[:tag_id])
      novels = @tag.novels.order(created_at: :desc)
    else
      novels = Novel.all.order(created_at: :desc)
    end
    @tag_lists = NovelTag.all
    @novels = Kaminari.paginate_array(novels).page(params[:page]).per(10)
  end

  def show
    @novel = Novel.find(params[:id])
    @novel_comment = NovelComment.new
  end

  def create
    @room = Room.find(params[:room_id])
    @novel = Novel.new(novel_params)
    @novel.room_id = @room.id
    tag_list = params[:novel][:tag_name].split(/\s/)
    @novel.image.attach(params[:novel][:image])
    @novel.user_id = current_user.id
    if @novel.save
      @novel.save_novels(tag_list)
      redirect_to room_novel_path(@novel.room_id,@novel)
    else
      flash.now[:alert] = "投稿に失敗しました"
      render "new"
    end
  end

  def edit
    @novel = Novel.find(params[:id])
    @room = Room.find(params[:room_id])
    if @novel.user == current_user
      render "edit"
    else
      redirect_to room_novels_path
    end
  end

  def update
    @novel = Novel.find(params[:id])
    tag_list = params[:novel][:tag_name].split(/\s/)
    if  @novel.user == current_user
      if @novel.update(novel_params)
        @novel.save_novels(tag_list)
        redirect_to room_novel_path(@novel.id)
      else
        render "edit"
      end
    else
      redirect_to root_path
    end
  end

  def destroy
    @novel = Novel.find(params[:id])
    if @novel.user == current_user
      @novel.destroy
      redirect_to room_novels_path
    else
      redirect_to root_path
    end
  end

  private

  def novel_params
    params.require(:novel).permit(:title, :body, :image)
  end



end
