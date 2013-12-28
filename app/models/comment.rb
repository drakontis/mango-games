class Comment < ActiveRecord::Base

  attr_accessible :body,
                  :user,
                  :user_id,
                  :game,
                  :game_id

  validates :body,    :presence => true
  validates :user_id, :presence => true
  validates :game_id, :presence => true

  belongs_to :user, :class_name => 'User'
  belongs_to :game, :class_name => 'Game'
end