class RemoveTwitterUidFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :twitter_uid
      end

  def down
    add_column :users, :twitter_uid, :string
  end
end
