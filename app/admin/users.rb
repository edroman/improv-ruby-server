ActiveAdmin.register User do

  index do
    column :first_name
    column :email
    column :phone
    column :password
    default_actions
  end

  form do |f|
#    f.inputs do
#      f.input :teams # add teams input here
#    end

    f.inputs

#    f.inputs "Teams" do
      f.has_many :teams do |j|
        j.input :name
        if !j.object.nil?
          j.input :_destroy, :as => :boolean, :label => "Delete"
        end
      end
#    end

    f.buttons
  end

  show do
    attributes_table do
      row :first_name
      row :email
      row :phone
      row :password
      user.teams.each { |team| row("Team"){team.name} }   # for each team, create a row with that team's name
    end
    active_admin_comments
  end

end
