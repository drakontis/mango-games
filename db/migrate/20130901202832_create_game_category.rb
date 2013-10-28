class CreateGameCategory < ActiveRecord::Migration
  def change
    create_table :categories_games do |t|
      t.integer :game_id,     :null => false
      t.integer :category_id, :null => false
    end

    add_foreign_key :categories_games, :games, :column => :game_id, :name => 'categories_games_game_fk'
    add_foreign_key :categories_games, :categories, :column => :category_id, :name => 'categories_games_category_fk'
  end
end
