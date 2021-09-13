class Novel < ApplicationRecord
  has_many :notifications  , dependent: :destroy
  has_many :bookmarks      , dependent: :destroy
  has_many :novel_favorites, dependent: :destroy
  has_many :novel_tagmaps  , dependent: :destroy
  has_many :novel_comments , dependent: :destroy
  has_many :novel_tags     , dependent: :destroy

  belongs_to :room
  belongs_to :user
end
