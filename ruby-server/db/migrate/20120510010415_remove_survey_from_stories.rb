class RemoveSurveyFromStories < ActiveRecord::Migration
  def up
    remove_column :stories, :survey_comments
        remove_column :stories, :survey_rating
      end

  def down
    add_column :stories, :survey_rating, :integer
    add_column :stories, :survey_comments, :text
  end
end
