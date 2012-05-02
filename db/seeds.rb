# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create(:email => 'admin@example.com', :password => 'admin', :password_confirmation => 'admin')
AdminUser.create(:email => 'edward.w.roman@gmail.com', :password => 'admin', :password_confirmation => 'admin')
AdminUser.create(:email => 'janetz@gmail.com', :password => 'admin', :password_confirmation => 'admin')
AdminUser.create(:email => 'acylum@gmail.com', :password => 'admin', :password_confirmation => 'admin')

# Base seed users for testing
User.create(first_name: 'Ed', email: 'edward.w.roman@gmail.com', phone: '+1 512-773-5555', password: 'admin')
User.create(first_name: 'Janet', email: 'janetz@gmail.com', phone: '+1 650-766-0778', password: 'admin')
User.create(first_name: 'Cyrus', email: 'acylum@gmail.com', phone: '+1 512-423-1532', password: 'admin')

# For SMS testing
User.create(first_name: 'Ed Test Partner', email: 'ed-test@gmail.com', phone: '+1 512-773-5555', password: 'admin')
User.create(first_name: 'Janet Test Partner', email: 'janet-test@gmail.com', phone: '+1 650-766-0778', password: 'admin')
User.create(first_name: 'Cyrus Test Partner', email: 'cyrus-test@gmail.com', phone: '+1 512-423-1532', password: 'admin')

Noun.create(name: 'zebra')
Noun.create(name: 'Obama')
Noun.create(name: 'gladiator')
Noun.create(name: 'grandma')
Noun.create(name: 'penguin')
Noun.create(name: 'doggy')
Noun.create(name: 'goldfish')
Noun.create(name: 'Bob')
Noun.create(name: 'entrepreneur')
Noun.create(name: 'eskimo')
Verb.create(name: 'shriek')
Verb.create(name: 'chirp')
Verb.create(name: 'crash')
Verb.create(name: 'peep')
Verb.create(name: 'punch')
Verb.create(name: 'jump')
Verb.create(name: 'bow')
Verb.create(name: 'peep')
Verb.create(name: 'growl')
Intro.create(name: 'Once upon a time, we were walking through the forest...')
Intro.create(name: 'In a land that time forgot...')
Intro.create(name: 'In the not-too-distant future...')