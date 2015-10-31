# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



require 'faker'

50.times do
 # #1
   Wiki.create!(
 # #2
     title:  Faker::Lorem.sentence,
     body:   Faker::Lorem.paragraph
   )
 end
 wikis = Wiki.all


20.times do
 # #1
   User.create!(
 # #2
     email: Faker::Internet.email,
     password: Faker::Internet.password
   )
 end
 users = User.all