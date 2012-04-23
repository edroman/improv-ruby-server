class CreateVerbs < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.text :name

      t.timestamps
    end
  end
end
