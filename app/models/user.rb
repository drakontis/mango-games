require 'digest/sha2'

class User < ActiveRecord::Base

  attr_accessor :password_confirmation
  attr_reader   :password

  attr_accessible :username, :password, :email, :rank, :rank_id, :password_confirmation

  belongs_to :rank,     :class_name => 'Rank'
  has_many   :games,    :class_name => 'Game'
  has_many   :comments, :class_name => 'Comment'
  has_many   :images,   :class_name => 'Image'
  has_many   :ratings,  :class_name => 'GameRating'

  validates :username, :presence => true,    :uniqueness => true
  validates :password, :confirmation => true
  validates :email,    :presence => true,    :uniqueness => true
  validates :rank_id,  :presence => true

  validate  :password_must_be_present

  nilify_blanks

  class << self
    def authenticate(username, password)
      if user = find_by_username(username)
        if user.hashed_password == encrypt_password(password, user.salt)
          user
        end
      end
    end

    def encrypt_password(password, salt)
      Digest::SHA2.hexdigest(password + "wibble" + salt)
    end
  end

  # 'password' is a virtual attribute
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end

  def root?
    username == 'root' || username == 'Root'
  end

  private

  def password_must_be_present
    errors.add(:password, "Missing password") unless hashed_password.present?
  end

  def generate_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end