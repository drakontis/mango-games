class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :user_id, :null => false
      t.integer :game_id, :null => false

      t.timestamps
    end

    add_foreign_key :images, :users, :column => :user_id, :name => 'images_user_fk'
    add_foreign_key :images, :games, :column => :game_id, :name => 'images_game_fk'
  end
end
