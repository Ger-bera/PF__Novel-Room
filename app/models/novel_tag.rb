class NovelTag < ApplicationRecord
  has_many :novel_tagmaps, dependent: :destroy,foreign_key: 'novel_id'
  has_many :novels, through: :novel_tagmaps
end
