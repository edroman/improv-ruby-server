class CreateConstraints < ActiveRecord::Migration
  def change
    create_table :constraints do |t|
      t.string :phrase
      t.string :type
      t.boolean :active

      t.timestamps
    end
  end
end
