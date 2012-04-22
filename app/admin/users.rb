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
      row :stories do
        user.stories.collect{|t| t.name}.join(', ')
      end
    end
    active_admin_comments
  end

end
