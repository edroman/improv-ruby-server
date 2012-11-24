class RemoveDataFromUser < ActiveRecord::Migration
  def up
    remove_column :users, :random_partner
        remove_column :users, :provider
      end

  def down
    add_column :users, :provider, :string
    add_column :users, :random_partner, :boolean
  end
end
