class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :code, :null => false
      t.string :name

      t.timestamps
    end

    add_index :categories, :code, :unique => true, :name => 'categories_code_uidx'
  end
end
