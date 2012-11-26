class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :user_id
      t.integer :story_id
      t.text :comments
      t.integer :rating

      t.timestamps
    end
  end
end
