class Room < ApplicationRecord
  has_many :notifications , dependent: :destroy
  has_many :novels        , dependent: :destroy
  has_many :room_comments , dependent: :destroy
  has_many :room_tagmaps  , dependent: :destroy
  has_many :room_tags     , dependent: :destroy
  has_many :room_favorites, dependent: :destroy
  
  belongs_to :user
end
