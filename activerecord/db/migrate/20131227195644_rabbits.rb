class Rabbits < ActiveRecord::Migration
  def up
    create_table :rabbits do |t|
      t.string :name, :unique => true
      t.text :description
      t.integer :age
      t.string :color
      t.string :breed
      t.timestamps
    end
  end

  def down
    drop_table :rabbits
  end
end
