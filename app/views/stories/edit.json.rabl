# Show the current @story from the controller
object @story

# Within each story, display these attributes of the stories
attributes :number, :turn, :all_sentences

# Make a new node that contains the phrase for the current constraint
node :constraint do |story|
  story.curr_sentence.constraint.phrase
end

# Make a new node called "partner" and have it contain the partner's name of the current story
node :partner do |story|
  story.partner(current_user).name
end
