# Show all the @stories from the controller
collection @stories

# Within each story, display these attributes of the stories
attributes :id, :all_sentences_preview

# Within each story, create a custom node called "partner" and have it contain the partner's name of the current story
node :partner do |story|
  story.partner(current_user).name
end
