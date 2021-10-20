class RoomTag < ApplicationRecord
  has_many :room_tagmaps, dependent: :destroy, foreign_key: 'room_id'
  has_many :rooms, through: :room_tagmaps
end
