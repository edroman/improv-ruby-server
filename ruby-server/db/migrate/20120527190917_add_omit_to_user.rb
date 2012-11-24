class AddOmitToUser < ActiveRecord::Migration
  def change
    add_column :users, :omit_from_random, :boolean, :default => false
  end
end
