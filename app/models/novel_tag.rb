class NovelTag < ApplicationRecord
  has_many :novel_tagmaps, dependent: :destroy
  has_many :novels, through: :novel_tagmaps
end
