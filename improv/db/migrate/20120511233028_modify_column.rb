class ModifyColumn < ActiveRecord::Migration
  def change
    remove_column :constraints, :part_of_speech
    add_column :constraints, :category_id, :integer
  end
end
