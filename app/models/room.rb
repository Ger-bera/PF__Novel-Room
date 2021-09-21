class Room < ApplicationRecord
  has_many :notifications , dependent: :destroy
  has_many :novels        , dependent: :destroy
  has_many :room_comments , dependent: :destroy
  has_many :room_tagmaps  , dependent: :destroy
  has_many :room_tags     , dependent: :destroy, through: :room_tagmaps
  has_many :room_favorites, dependent: :destroy

  belongs_to :user

  def favorited_by?(user)
   room_favorites.where(user_id: user.id).exists?
  end

  def self.rooms_serach(search)
   Room.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  end

  def save_rooms(room_tags)
   current_tags = self.room_tags.pluck(:tag_name) unless self.room_tags.nil?
   old_tags = current_tags - room_tags
   new_tags = room_tags - current_tags

   old_tags.each do |old_name|
     self.room_tags.delete RoomTag.find_by(tag_name: old_name)
   end

   new_tags.each do |new_name|
     room_tag = RoomTag.find_by(tag_name: new_name)
     room_tag = RoomTag.create(tag_name: new_name, room_id: self.id) if room_tag.nil?
     self.room_tags << room_tag #見えないけど中間テーブルを経由している
   end
  end
end
