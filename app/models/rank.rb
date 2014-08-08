class Rank < ActiveRecord::Base

  attr_accessible :code,
                  :name,
                  :rank_privileges,
                  :rank_privileges_attributes

  validates :code, :presence => true, :uniqueness => true

  has_many :users, :class_name => 'User'
  has_many :rank_privileges, :class_name => 'RankPrivilege', :inverse_of => :rank, :dependent => :destroy

  accepts_nested_attributes_for :rank_privileges, :allow_destroy => true

  nilify_blanks
end