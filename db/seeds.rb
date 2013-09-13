# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'SETTING UP DEFAULT USER LOGIN'
Agent.find_or_initialize_by(email: 'ruslan@helperchat.com') do |user|
  user.password = 'changeme'
  user.password_confirmation = 'changeme'
end.save!

puts 'New user created: email / ruslan@helperchat.com password / changeme'

puts 'SETTING UP DEFAULT ADMIN LOGIN'
Agent.find_or_initialize_by(email: 'admin@helperchat.com') do |user|
  user.password = 'changeme'
  user.password_confirmation = 'changeme'
end.save!

puts 'New user created: email / admin@helperchat.com password / changeme'

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