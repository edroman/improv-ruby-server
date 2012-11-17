class RemoveJoinTable < ActiveRecord::Migration
  def change
    drop_table :users_stories
  end
end
