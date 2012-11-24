class ChangeFacebookUidDataType < ActiveRecord::Migration
  def change
    remove_column :users, :facebook_uid
    add_column :users, :facebook_uid, :integer, :limit => 8
  end
end
