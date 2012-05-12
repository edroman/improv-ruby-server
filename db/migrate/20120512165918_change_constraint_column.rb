class ChangeConstraintColumn < ActiveRecord::Migration
  def change
    change_column :constraints, :active, :boolean, :null => false, :default => true
  end
end
