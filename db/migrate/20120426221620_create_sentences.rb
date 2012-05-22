class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.text :body
      t.integer :constraint_id

      t.timestamps
    end
  end
end
