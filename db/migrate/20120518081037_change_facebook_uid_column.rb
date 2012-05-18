class ChangeFacebookUidColumn < ActiveRecord::Migration
  def change
    change_column :users, :facebook_uid, :bigint
  end
end
