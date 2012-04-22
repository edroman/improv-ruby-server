class CreateConstraints < ActiveRecord::Migration
  def change
    create_table :constraints do |t|
      t.string :name
      t.string :grammar

      t.timestamps
    end
  end
end
