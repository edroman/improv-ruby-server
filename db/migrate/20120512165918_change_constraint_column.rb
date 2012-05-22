class ChangeConstraintColumn < ActiveRecord::Migration
  def change
    remove_column :constraints, :active
    add_column :constraints, :active, :boolean, :null => false, :default => true
  end
end
