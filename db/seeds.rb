# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'EMPTY THE MONGODB DATABASE'
#Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
puts 'SETTING UP DEFAULT USER LOGIN'
User.create! :name => 'ruslan', :email => 'ruslan@example.com', :password => 'changeme', :password_confirmation => 'changeme'
puts 'New user created: email / ruslan@example.com password / changeme'

puts 'SETTING UP DEFAULT ADMIN LOGIN'
User.create! :name => 'admin', :email => 'admin@example.com', :password => 'changemeadmin', :password_confirmation => 'changemeadmin'
puts 'New user created: email / admin@example.com password / changemeadmin'