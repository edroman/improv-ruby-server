class RemoveStuffFromStory < ActiveRecord::Migration
  def change
    remove_column :stories, :sentences
    remove_column :stories, :constraints
  end
end
