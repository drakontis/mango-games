class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text    :body,    :null => false
      t.integer :user_id, :null => false
      t.integer :game_id, :null => false

      t.timestamps
    end

    add_foreign_key :comments, :users, :column => :user_id, :name => 'comments_user_fk'
    add_foreign_key :comments, :games, :column => :game_id, :name => 'comments_game_fk'
  end
end
