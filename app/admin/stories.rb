ActiveAdmin.register Story do
  form do |f|
    f.inputs do
      f.input :number
      f.input :users, :as => :check_boxes
      f.input :turn
      f.input :sentences
    end
    f.buttons
  end

  index do
    column :id
    column :number
    column :turn
    column :sentences
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :number
      row :turn
      row :sentences
      row :users do
        story.users.collect{|t| t.name}.join(', ')
      end
    end
    active_admin_comments
  end

end
