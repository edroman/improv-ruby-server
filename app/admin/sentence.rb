ActiveAdmin.register Sentence do

  actions :all, :except => [:new, :destroy, :edit]

  form do |f|
    f.inputs
    f.buttons
  end

  index do
    column :body
    column :constraint
    column :story
    column :turn
    column :feedback
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :body
      row :constraint
      row :story
      row :turn
      row :feedback
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
