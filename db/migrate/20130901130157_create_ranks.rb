class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.integer :code, :null => false
      t.string  :name

      t.timestamps
    end

    add_index :ranks, :code, :unique => true, :name => 'ranks_code_uidx'
  end
end
