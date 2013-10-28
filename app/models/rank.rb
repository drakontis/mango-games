class Rank < ActiveRecord::Base

  attr_accessible :code, :name

  validates :code, :presence => true, :uniqueness => true

  has_many :users, :class_name => 'User'
end