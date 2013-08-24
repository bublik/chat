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
User.find_or_create_by(name: 'ruslan') do |user|
  user.email = 'ruslan@example.com'
  user.password = 'changeme'
  user.password_confirmation = 'changeme'
end.save

puts 'New user created: email / ruslan@example.com password / changeme'

puts 'SETTING UP DEFAULT ADMIN LOGIN'
User.find_or_create_by(name: 'admin') do |user|
  user.email = 'admin@example.com'
  user.password = 'changeme'
  user.password_confirmation = 'changeme'
end.save

puts 'New user created: email / admin@example.com password / changeme'

[
    'Интернет-магазин',
    'информационный сайт',
    'Игровой портал',
    'Блог',
    'Социальная сеть',
    'Путешествие',
    'Товары для дома',
    'Интернет провайдер',
    'Развлечения',
    'Азартные игры',
    'Коммунальные услуги',
    'Туристические услуги',
    'Гостинница',
    'Интернет услуги',
    'Новостной портал'
].each do |name|
  puts "Category #{name} added!" if  SiteCategory.find_or_create_by(name: name)
end