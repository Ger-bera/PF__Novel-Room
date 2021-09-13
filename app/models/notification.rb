class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :novel        , optional: true
  belongs_to :novel_comment, optional: true
  belongs_to :room         , optional: true
  belongs_to :room_comment , optional: true
  belongs_to :bookmark     , optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
