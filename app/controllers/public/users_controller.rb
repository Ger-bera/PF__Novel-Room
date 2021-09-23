class Public::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_post,only: [:edit]

  def show
    @user = User.find(params[:id])
    @bookmarks = Bookmark.where(user_id: current_user.id)
    @novels = @user.novels
    @rooms = @user.rooms
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "ご利用いただきありがとうございました！"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def correct_post
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
  end

end
