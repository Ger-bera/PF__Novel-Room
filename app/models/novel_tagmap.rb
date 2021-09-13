class NovelTagmap < ApplicationRecord
  belongs_to :novel_tag
  belongs_to :novel
end
