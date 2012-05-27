ActiveAdmin.register User do

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :phone
      f.input :facebook_uid
      f.input :facebook_token
      f.input :twitter_token
      f.input :twitter_secret
      f.input :super_user
      f.input :sms_notification
      f.input :omit_from_random
    end
    f.buttons
  end

  index do
    column :first_name
    column :email
    column :phone
    column :password
    column :facebook_uid
    column :twitter_token
    column :super_user
    column :sms_notification
    column :omit_from_random
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
      row :facebook_uid
      row :facebook_token
      row :twitter_token
      row :twitter_secret
      row :super_user
      row :sms_notification
      row :omit_from_random
    end
    active_admin_comments
  end

end
