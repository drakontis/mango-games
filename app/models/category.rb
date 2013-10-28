class Category < ActiveRecord::Base

  attr_accessible :code, :name

  validates :code, :presence => true, :uniqueness => true

  has_and_belongs_to_many :games
end