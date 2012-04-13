ActiveAdmin.register Story do
  form do |f|
    f.inputs do
      f.input :number
      f.input :team, :include_blank => false
      f.input :turn
      f.input :sentences
      f.input :constraints
    end
    f.buttons
  end

  index do
    column :id
    column :number
    column :team
    column :turn
    column :sentences
    column :constraints
    column :created_at
    column :updated_at
    default_actions
  end
end
