class RemoveFacebookSecretFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :facebook_secret
      end

  def down
    add_column :users, :facebook_secret, :string
  end
end
