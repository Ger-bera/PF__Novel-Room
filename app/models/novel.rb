class Novel < ApplicationRecord
  has_many :notifications  , dependent: :destroy
  has_many :bookmarks      , dependent: :destroy
  has_many :novel_favorites, dependent: :destroy
  has_many :novel_tagmaps  , dependent: :destroy
  has_many :novel_comments , dependent: :destroy
  has_many :novel_tags     , through: :novel_tagmaps

  belongs_to :room
  belongs_to :user

  def self.novels_serach(search)
   Novel.where(['title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%"])
  end

  def save_novels(novel_tags)
   current_tags = self.novel_tags.pluck(:tag_name) unless self.novel_tags.nil?
   old_tags = current_tags - novel_tags
   new_tags = novel_tags - current_tags

   # Destroy
   old_tags.each do |old_name|
    self.novel_tags.delete NovelTag.find_by(tag_name:old_name)
   end

   # Create
   new_tags.each do |new_name|
    novel_tag = NovelTag.find_by(tag_name: new_name)
    novel_tag = NovelTag.create(tag_name: new_name, novel_id: self.id) if novel_tag.nil?
    self.novel_tags << novel_tag
   end
  end
end
