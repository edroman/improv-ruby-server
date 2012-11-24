class AddSurveyToSentence < ActiveRecord::Migration
  def change
    add_column :sentences, :survey_comments, :text

    add_column :sentences, :survey_rating, :integer

  end
end
