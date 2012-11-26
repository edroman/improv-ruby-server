class RenameAColumn < ActiveRecord::Migration
  def change
    rename_column :constraints, :category_id, :constraint_category_id
  end
end
