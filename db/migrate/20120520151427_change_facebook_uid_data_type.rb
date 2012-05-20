class ChangeFacebookUidDataType < ActiveRecord::Migration
  def change
    change_column :users, :facebook_uid, :integer, :limit => 8
  end
end
