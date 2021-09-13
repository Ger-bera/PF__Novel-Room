class Bookmark < ApplicationRecord
  has_many :notifications, dependent: :destroy

  belongs_to :novel
  belongs_to :user
end
