class Novel < ApplicationRecord
  has_many :notifications  , dependent: :destroy
  has_many :bookmarks      , dependent: :destroy
  has_many :novel_favorites, dependent: :destroy
  has_many :novel_tagmaps  , dependent: :destroy
  has_many :novel_comments , dependent: :destroy
  has_many :novel_tags     , dependent: :destroy, through: :novel_tagmaps

  belongs_to :room
  belongs_to :user

  has_one_attached :image



  def create_notification_novelcomment(current_user, novel_comment_id)
    save_notification_comment(current_user, novel_comment_id, user_id)
  end

  def save_notification_novelcomment(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      novel_id: id,
      novel_comment_id: novel_comment_id,
      visited_id: visited_id,
      action: 'novelcomment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

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




  def bookmarked_by?(user)
   bookmarks.where(user_id: user).exists?
  end

  def favorited_by?(user)
   novel_favorites.where(user_id: user.id).exists?
  end

  def self.novels_serach(search)
   Novel.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  end

  def save_novels(novel_tags)
   current_tags = self.novel_tags.pluck(:tag_name) unless self.novel_tags.nil?
   old_tags = current_tags - novel_tags
   new_tags = novel_tags - current_tags

   old_tags.each do |old_name|
    self.novel_tags.delete NovelTag.find_by(tag_name: old_name)
   end

   new_tags.each do |new_name|
    novel_tag = NovelTag.find_by(tag_name: new_name)
    novel_tag = NovelTag.create(tag_name: new_name, novel_id: self.id) if novel_tag.nil?
    self.novel_tags << novel_tag #見えないけど中間テーブルを経由している
   end
  end
end
