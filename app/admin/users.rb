ActiveAdmin.register User do

  index do
    column :first_name
    column :email
    column :phone
    column :password
    default_actions
  end

  form do |f|

    f.inputs

    f.inputs do
      f.input :teams, :as => :check_boxes
    end


=begin
# failed techniques that don't work'
#    f.inputs do
#      f.input :teams # add teams input here
#    end
#    f.inputs "Teams" do
      f.has_many :teams do |j|
        j.input :name
        if !j.object.nil?
          j.input :_destroy, :as => :boolean, :label => "Delete"
        end
      end
#    end
=end
    f.buttons
  end

  show do
    attributes_table do
      row :first_name
      row :email
      row :phone
      row :password
      row :teams do
        user.teams.collect{|t| t.name}.join(', ')
      end

=begin
    # failed techniques that don't work'
    user.teams.each { |team| row("Team"){team.name} }   # for each team, create a row with that team's name
    row :teams
=end

    end
    active_admin_comments
  end

end
