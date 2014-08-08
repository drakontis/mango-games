class GameRating < ActiveRecord::Base
  attr_accessible :score,
                  :user,
                  :user_id,
                  :game,
                  :game_id

  belongs_to :user, :class_name => 'User'
  belongs_to :game, :class_name => 'Game'

  validates :user_id,  :presence => true, :uniqueness => { :scope => :game_id }
  validates :game_id,  :presence => true, :uniqueness => { :scope => :user_id }
  validates :score,    :presence => true

  nilify_blanks
end