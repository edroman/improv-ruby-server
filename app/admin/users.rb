ActiveAdmin.register User do

  form do |f|
    f.inputs
    f.buttons
  end

  index do
    column :first_name
    column :email
    column :phone
    column :password
    default_actions
  end

  show do
    attributes_table do
      row :first_name
      row :email
      row :phone
      row :password
      row 'Stories' do |user|
        user.stories.map { |story|
          link_to story.all_sentences_preview, admin_story_path(story)
        }.join("<br/>").html_safe
      end
    end
    active_admin_comments
  end

end
