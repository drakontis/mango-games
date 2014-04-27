class CreateGameRatings < ActiveRecord::Migration
  def change
    create_table :game_ratings do |t|
      t.integer  :score,   :null => false
      t.integer  :game_id, :null => false
      t.integer  :user_id, :null => false

      t.timestamps
    end

    add_index :game_ratings, [:game_id, :user_id], :unique => true, :name => 'game_ratings_game_user_uidx'

    add_foreign_key :game_ratings, :users, :column => :user_id, :name => 'game_ratings_user_fk'
    add_foreign_key :game_ratings, :games, :column => :game_id, :name => 'game_ratings_game_fk'
  end
end
