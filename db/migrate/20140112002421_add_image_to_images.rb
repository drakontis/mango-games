class AddImageToImages < ActiveRecord::Migration
  def self.up
    add_attachment :images, :image
  end

  def self.down
    remove_attachment :images, :image
  end
end
