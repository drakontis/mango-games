class Category < ActiveRecord::Base

  attr_accessible :code, :name

  validates :code, :presence => true, :uniqueness => true

  #has_many :game_categories, :class_name => 'GameCategory'
  has_and_belongs_to_many :games#,           :through => :game_categories
end