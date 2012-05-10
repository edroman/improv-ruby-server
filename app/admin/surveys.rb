ActiveAdmin.register Survey do

  actions :all

  form do |f|
    f.inputs
    f.buttons
  end

  index do
    column :user
    column :story
    column :comments
    column :rating
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :user
      row :story
      row :comments
      row :rating
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
