class Image < ActiveRecord::Base

  attr_accessible :user_id,
                  :user,
                  :game_id,
                  :game,
                  :image

  has_attached_file :image, :styles => { :medium => "500x500>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  validates :user_id, :presence => true

  belongs_to :game
  belongs_to :user
end