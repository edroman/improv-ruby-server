class AddTwitterSecretToUser < ActiveRecord::Migration
  def change
    add_column :users, :twitter_secret, :string

  end
end
