class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :email
      t.integer :phone
      t.string :password

      t.timestamps
    end
  end
end
