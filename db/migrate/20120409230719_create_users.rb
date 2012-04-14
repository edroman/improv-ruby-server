class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :email
      t.text :phone
      t.string :password

      t.timestamps
    end
  end
end
