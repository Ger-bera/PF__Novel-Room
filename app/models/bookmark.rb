class Bookmark < ApplicationRecord
  has_many :notifications, dependent: :destroy

  belongs_to :novel
  belongs_to :user

  validates :user_id, uniqueness: { scope: :novel_id }


  def create_notification_bookmark(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'bookmark'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'bookmark'
      )
      notification.save if notification.valid?
    end
  end





end
