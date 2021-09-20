class NovelFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :novel

  validates_uniqueness_of :novel_id, scope: :user_id
end
