class AddActiveToConstraintCategory < ActiveRecord::Migration
  def change
    add_column :constraint_categories, :active, :boolean

  end
end
