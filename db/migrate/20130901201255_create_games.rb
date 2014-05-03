class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string   :title,        :null => false
      t.text     :description,  :null => false
      t.text     :instructions, :null => false
      t.boolean  :approved,     :null => false, :default => false
      t.integer  :user_id,      :null => false

      t.timestamps
    end

    add_index :games, :title, :unique => true, :name => 'games_title_uidx'

    add_foreign_key :games, :users, :column => :user_id, :name => 'games_user_fk'
  end
end
