class AddSurveyToStory < ActiveRecord::Migration
  def change
    add_column :stories, :survey_comments, :text

    add_column :stories, :survey_rating, :integer

  end
end
