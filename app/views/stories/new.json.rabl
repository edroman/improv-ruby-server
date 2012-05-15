# Create a node named "partners".  Inside that node, find all relevant partners.  Use the map.() function to iterate over them,
# since .map() returns the results of the block, whereas .each() returns the original array.  Within the block, create a set
# of pairs of user names and user ids.
node :partners do
  User.all_except(current_user).map do |u|
    { :name => u.name, :id => u.id }
  end
end