class RoomTag < ApplicationRecord
  has_many :room_tagmaps, dependent: :destroy
  has_many :rooms, through: :room_tagmaps
end
