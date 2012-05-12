ActiveAdmin.register Constraint do

  actions :all, :except => [:destroy]

  form do |f|
    f.inputs
    f.buttons
  end

  index do
    column :phrase
    column :constraint_category
    column :active
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :phrase
      row :constraint_category
      row :active
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
