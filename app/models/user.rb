class User < ApplicationRecord
  has_many :bookmarks      , dependent: :destroy
  has_many :novels         , dependent: :destroy
  has_many :novel_favorites, dependent: :destroy
  has_many :novel_comments , dependent: :destroy
  has_many :rooms          , dependent: :destroy
  has_many :room_comments  , dependent: :destroy
  has_many :room_favorites , dependent: :destroy

  has_many :active_notifications , class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, uniqueness: true


  #退会済みユーザーはログインできない 
  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
