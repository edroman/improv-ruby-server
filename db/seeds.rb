# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: 'Admin', email: 'admin', phone: '123-456-7890', password: '')
Constraint.create(name: 'zebra', grammar: 'noun')
Constraint.create(name: 'statue', grammar: 'noun')
Constraint.create(name: 'gladiator', grammar: 'noun')
Constraint.create(name: 'blanket', grammar: 'noun')
Constraint.create(name: 'Michael Jordan', grammar: 'noun')
Constraint.create(name: 'discover', grammar: 'noun')
Constraint.create(name: 'paperweight', grammar: 'noun')
Constraint.create(name: 'goldfish', grammar: 'noun')
Constraint.create(name: 'bathroom', grammar: 'noun')
Constraint.create(name: 'destruction', grammar: 'noun')
Constraint.create(name: 'shriek', grammar: 'verb')
Constraint.create(name: 'whisper', grammar: 'verb')
Constraint.create(name: 'urinate', grammar: 'verb')
Constraint.create(name: 'peep', grammar: 'verb')
Constraint.create(name: 'punch', grammar: 'verb')
Constraint.create(name: 'fled', grammar: 'verb')
Constraint.create(name: 'shuffle', grammar: 'verb')
Constraint.create(name: 'peep', grammar: 'verb')
Constraint.create(name: 'urinate', grammar: 'verb')
Constraint.create(name: 'growl', grammar: 'verb')
