class CreateUsersStoriesJoin < ActiveRecord::Migration
  def up
    create_table 'users_stories', :id => false do |t|
      t.column :user_id, :integer
      t.column :story_id, :integer
    end
  end

  def down
    drop_table 'users_stories'
  end
end
