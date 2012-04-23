class CreateNouns < ActiveRecord::Migration
  def change
    create_table :nouns do |t|
      t.text :name

      t.timestamps
    end
  end
end
