class RoomTagmap < ApplicationRecord
  belongs_to :room_tag
  belongs_to :room
end
