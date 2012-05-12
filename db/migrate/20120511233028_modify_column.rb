class ModifyColumn < ActiveRecord::Migration
  def change
    change_column :constraints, :part_of_speech, :integer
    rename_column :constraints, :part_of_speech, :category_id
  end
end
