class CreateUsersTeamsJoin < ActiveRecord::Migration
  def up
    create_table 'users_teams', :id => false do |t|
      t.column :user_id, :integer
      t.column :team_id, :integer
    end
  end

  def down
    drop_table 'users_teams'
  end
end
