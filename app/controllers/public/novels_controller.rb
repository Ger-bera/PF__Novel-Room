class Public::NovelsController < ApplicationController

  def new
  end

  def index
    if params[:search].present? #検索欄にワードが存在するか？
      novels = Novel.novelss_serach(params[:search])
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
  end

  def create
    @novel = Novel.new(novel_params)
    tag_list = params[:novel][:tag_name].split
    @novel.image.attach(params[:novel][:image])
    @novel.user_id = current_user.id
    if @novel.save
       @novel.save_novels(tag_list)
      redirect_to room_novels_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render "new"
    end
  end

  def edit
    @novel = Novel.find(params[:id])
    if @novel.user == current_user
      render "edit"
    else
      redirect_to room_novels_path
    end
  end

  def update
    @novel = Novel.find(params[:id])
    if @novel.update(novel_params)
      redirect_to room_novel_path(@novel.id)
    else
      render "edit"
    end
  end

  def destroy
    @novel = Novel.find(params[:id])
    @novel.destroy
    redirect_to room_novels_path
  end

  private

  def novel_params
    params.require(:novel).permit(:title, :body, :image)
  end



end
