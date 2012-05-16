class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :story_id
      t.integer :user_id
      t.integer :player_number

      t.timestamps
    end
  end
end
