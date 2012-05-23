ActiveAdmin.register User do

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone
      f.input :super_user
      f.input :sms_notification
      f.input :facebook_uid
      f.input :facebook_token
      f.input :twitter_token
      f.input :twitter_secret
    end
    f.buttons
  end

  index do
    column :first_name
    column :email
    column :phone
    column :password
    column :super_user
    column :sms_notification
    column :facebook_uid
    column :twitter_token
    default_actions
  end

  show do
    attributes_table do
      row :first_name
      row :email
      row :phone
      row :password
      row :super_user
      row :sms_notification
      row :facebook_uid
      row :facebook_token
      row :twitter_token
      row :twitter_secret
      row 'Stories' do |user|
        user.stories.map { |story|
          link_to story.all_sentences_preview, admin_story_path(story)
        }.join("<br/>").html_safe
      end
    end
    active_admin_comments
  end

end
