class RoomFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :room
end
