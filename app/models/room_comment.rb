class RoomComment < ApplicationRecord
  has_many :notifications, dependent: :destroy

  belongs_to :room
  belongs_to :user
end
