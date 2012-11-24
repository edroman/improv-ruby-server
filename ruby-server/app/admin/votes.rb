ActiveAdmin.register Vote do

  form do |f|
    f.inputs do
      f.input :user
      f.input :story
    end
    f.buttons
  end

  index do
    column :user
    column :story
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :user
      row :story
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
