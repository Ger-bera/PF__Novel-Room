class NovelTag < ApplicationRecord
  has_many :novel_tagmaps, dependent: :destroy
  has_many :novel, through: :novel_tagmaps
end
