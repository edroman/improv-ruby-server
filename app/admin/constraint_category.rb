ActiveAdmin.register ConstraintCategory do

  actions :all, :except => [:destroy]

  form do |f|
    f.inputs
    f.buttons
  end

  index do
    column :value
    column :active
    column :created_at
    column :updated_at
    default_actions
  end

  show do
    attributes_table do
      row :value
      row :active
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
