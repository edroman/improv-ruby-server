class RenameColumn < ActiveRecord::Migration
  def change
    rename_column :constraints, :type, :part_of_speech
  end
end
