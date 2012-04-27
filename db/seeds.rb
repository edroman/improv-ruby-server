# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

AdminUser.create(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')
AdminUser.create(:email => 'edward.w.roman@gmail.com', :password => 'password', :password_confirmation => 'password')
AdminUser.create(:email => 'janetz@gmail.com', :password => 'password', :password_confirmation => 'password')
AdminUser.create(:email => 'acylum@gmail.com', :password => 'password', :password_confirmation => 'password')

# Base seed users for testing
User.create(first_name: 'Ed', email: 'edward.w.roman@gmail.com', phone: '+1 512-773-5555', password: '')
User.create(first_name: 'Janet', email: 'janetz@gmail.com', phone: '+1 650-766-0778', password: '')
User.create(first_name: 'Cyrus', email: 'acylum@gmail.com', phone: '+1 512-423-1532', password: '')

# For SMS testing
User.create(first_name: 'Ed Test Partner', email: 'ed-test', phone: '+1 512-773-5555', password: '')
User.create(first_name: 'Janet Test Partner', email: 'janet-test', phone: '+1 650-766-0778', password: '')
User.create(first_name: 'Cyrus Test Partner', email: 'cyrus-test', phone: '+1 512-423-1532', password: '')

Noun.create(name: 'zebra')
Noun.create(name: 'Obama')
Noun.create(name: 'gladiator')
Noun.create(name: 'grandma')
Noun.create(name: 'Michael Jordan')
Noun.create(name: 'doggy')
Noun.create(name: 'goldfish')
Noun.create(name: 'toilet')
Noun.create(name: 'destruction')
Noun.create(name: 'discover')
Verb.create(name: 'shriek')
Verb.create(name: 'whisper')
Verb.create(name: 'urinate')
Verb.create(name: 'peep')
Verb.create(name: 'punch')
Verb.create(name: 'fled')
Verb.create(name: 'shuffle')
Verb.create(name: 'peep')
Verb.create(name: 'urinate')
Verb.create(name: 'growl')
Intro.create(name: 'Once upon a time, we were walking through the forest...')
Intro.create(name: 'In a land that time forgot...')
Intro.create(name: 'In the not-too-distant future...')