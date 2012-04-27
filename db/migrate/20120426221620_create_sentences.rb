class CreateSentences < ActiveRecord::Migration
  def change
    create_table :sentences do |t|
      t.text :body
      t.text :constraint

      t.timestamps
    end
  end
end
