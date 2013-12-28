class Game < ActiveRecord::Base

  attr_accessible :title,
                  :description,
                  :approved,
                  :user,
                  :user_id,
                  :category_ids

  validates :title,       :presence => true, :uniqueness => true
  validates :description, :presence => true
  #validates :approved,    :presence => true
  validates :user_id,     :presence => true

  belongs_to :user,   :class_name => 'User'
  has_many :comments, :class_name => 'Comment'
  has_and_belongs_to_many :categories
end