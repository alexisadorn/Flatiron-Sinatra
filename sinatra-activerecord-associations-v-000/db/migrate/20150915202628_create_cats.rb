class CreateCats < ActiveRecord::Migration
  def up
    create_table :cats do |t|
      t.string :name
      t.integer :age
      t.string :breed
    end
  end
  
  def down
    drop_table :cats
  end
end
