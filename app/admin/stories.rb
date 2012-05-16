ActiveAdmin.register Story do

  actions :all, :except => [:new, :edit]

  form do |f|
    f.inputs do
#      f.input :number
      f.input :users, :as => :check_boxes
#      f.input :turn
#      f.input :sentences
    end
    f.buttons
  end

  index do
    column :id
    column :number
    column :turn
    column :sentences do |story|
      story.all_sentences_preview
    end
    column 'Surveys' do |story|
      story.surveys.map { |survey|
        link_to survey.comments, admin_survey_path(survey)
      }.join("<br/>").html_safe
    end
    column :curr_playing_user
    column :curr_waiting_user
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :number
      row :turn
      row :sentences do |story|
        story.all_sentences
      end
      row 'Sentences' do |story|
        story.sentences.map { |sentence|
          link_to sentence.body, admin_sentence_path(sentence)
        }.join("<br/>").html_safe
      end
      row 'Surveys' do |story|
        story.surveys.map { |survey|
          link_to survey.comments, admin_survey_path(survey)
        }.join("<br/>").html_safe
      end
      row :curr_playing_user
      row :curr_waiting_user
    end
    active_admin_comments
  end

end
