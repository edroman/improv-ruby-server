ActiveAdmin.register Team do

  index do
    column :id
    column :name
    default_actions
  end


  form do |f|

    f.inputs do
      f.input :stories, :as => :check_boxes
    end

    f.inputs do
      f.input :users, :as => :check_boxes
    end

=begin
    # Broken alternative techniques that failed:

    f.inputs "Stories" do
      f.input :stories
    end

    f.has_many :stories do |j|
      j.input :sentences
      if !j.object.nil?
        j.input :_destroy, :as => :boolean, :label => "Delete"
      end
    end
=end

    f.buttons
  end

  show do
    attributes_table do
      row("Team Name"){team.name}

      row :users do
        team.users.collect{|t| t.name}.join(', ')
      end
      row :stories do
        team.stories.collect{|t| t.name}.join(', ')
      end

=begin
    # Broken alternative techniques that failed:
      row :users do
        team.users.collect{|t| t}.join(', ')
      end

      row("Users"){team.users}
      team.users.each { |user| row("User"){user.first_name} }   # for each user, create a row with that user's name
      team.stories.each { |story| row("Story"){story.sentences} }   # for each story, create a row with that story's sentences'
=end
    end
    active_admin_comments
  end
end
