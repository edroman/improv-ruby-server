class AddRandomPartnerToUser < ActiveRecord::Migration
  def change
    add_column :users, :random_partner, :boolean

  end
end
