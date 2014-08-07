class CreateRankPrivileges < ActiveRecord::Migration
  def change
    create_table :rank_privileges do |t|
      t.integer :rank_id, :null => false
      t.string  :model,   :null => false, :limit => 64
      t.string  :action,  :null => false, :limit => 32

      t.timestamps
    end

    add_index       :rank_privileges, [:model, :action, :rank_id], :unique => true, :name => 'rank_privileges_model_action_rank_uidx'
    add_foreign_key :rank_privileges, :ranks, :column => 'rank_id', :name => 'rank_privileges_rank_fk'
  end
end
