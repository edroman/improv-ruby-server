class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.integer :number
      t.integer :turn, :default => 1

      t.timestamps
    end
  end
end
