class AddIntroToStory < ActiveRecord::Migration
  def change
    add_column :stories, :intro, :text

  end
end
