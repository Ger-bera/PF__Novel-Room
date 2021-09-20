class Bookmark < ApplicationRecord
  has_many :notifications, dependent: :destroy

  belongs_to :novel
  belongs_to :user

  validates :user_id, uniqueness: { scope: :novel_id }

end
