class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :number
      t.integer :turn
      t.text :sentences
      t.text :constraints

      t.timestamps
    end
  end
end
