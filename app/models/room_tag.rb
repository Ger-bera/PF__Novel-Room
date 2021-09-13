class RoomTag < ApplicationRecord
  has_many :room_tagmaps, dependent: :destroy
  has_many :room        , through: :room_tagmaps

  belongs_to :room
end
