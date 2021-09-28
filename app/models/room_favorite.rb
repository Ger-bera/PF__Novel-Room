class RoomFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates_uniqueness_of :room_id, scope: :user_id

  def create_notification_roomfavorite(current_user)
  # すでに「いいね」されているか検索(連打での嫌がらせ防止)
  temp = Notification.where(["visitor_id = ? and visited_id = ? and room_favorite_id = ? and action = ? ", current_user.id, user_id, id, 'roomfavorite'])
  # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
      room_favorite_id: id,
      visited_id: room.user_id,
      action: 'roomfavorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end


end
