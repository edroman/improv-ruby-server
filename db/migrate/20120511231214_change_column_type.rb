class ChangeColumnType < ActiveRecord::Migration
  def change
	change_column :sentences, :constraint, :integer
	rename_column :sentences, :constraint, :constraint_id
  end
end
