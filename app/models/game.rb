class Game < ActiveRecord::Base

  attr_accessible :title,
                  :description,
                  :instructions,
                  :approved,
                  :user,
                  :user_id,
                  :category_ids,
                  :images,
                  :images_attributes

  validates :title,        :presence => true, :uniqueness => true
  validates :description,  :presence => true
  #validates :approved,    :presence => true
  validates :user_id,      :presence => true
  validates :instructions, :presence => true

  belongs_to :user,   :class_name => 'User'
  has_many :comments, :class_name => 'Comment'
  has_many :images,   :class_name => 'Image'
  has_many :ratings,  :class_name => 'GameRating'
  has_and_belongs_to_many :categories

  accepts_nested_attributes_for :images

  def average_rating
    ratings.size.zero? ? 0 : (ratings.sum(:score).to_f / ratings.size)
  end

  nilify_blanks
end