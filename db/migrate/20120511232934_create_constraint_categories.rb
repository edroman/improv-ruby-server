class CreateConstraintCategories < ActiveRecord::Migration
  def change
    create_table :constraint_categories do |t|
      t.string :value

      t.timestamps
    end
  end
end
