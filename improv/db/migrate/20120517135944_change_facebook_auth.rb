class ChangeFacebookAuth < ActiveRecord::Migration
  def change
    rename_column :users, :token, :facebook_token
    rename_column :users, :secret, :facebook_secret
    remove_column :users, :uid
  end
end
