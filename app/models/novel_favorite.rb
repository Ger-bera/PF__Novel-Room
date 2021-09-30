class NovelFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :novel
  has_many :notifications, dependent: :destroy
  validates_uniqueness_of :novel_id, scope: :user_id



  def create_notification_novelfavorite(current_user)
  # すでに「いいね」されているか検索(連打での嫌がらせ防止)
  temp = Notification.where(["visitor_id = ? and visited_id = ? and novel_favorite_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
  # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
      novel_id: novel.id,
      novel_favorite_id: id,
      visited_id: novel.user_id,
      action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end
