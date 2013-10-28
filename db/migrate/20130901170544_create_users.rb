class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :username,        :null => false
      t.string  :hashed_password, :null => false
      t.string  :salt
      t.string  :email,           :null => false
      t.integer :rank_id,         :null => false

      t.timestamps
    end

    add_foreign_key :users, :ranks, :column => :rank_id, :name => 'users_rank_fk'
  end
end
