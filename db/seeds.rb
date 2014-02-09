# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "creating admin user.."
User.create!(email: "admin@bookworm.io", password: "password", password_confirmation: "password", role: "admin")

puts "creating member user.."
User.create!(email: "user@drexel.edu", password: "password", password_confirmation: "password", role: "member")

if Rails.env == "development"
  puts "creating books"

  6.times do
    Book.create!({title: Faker::Lorem.sentence(3,false,3), author: Faker::Name.name, summary: Faker::Lorem.paragraph, page_count: Faker::Number.number(2), isbn: Faker::Number.number(13).to_s, tag_list: 'fiction' })
  end

  6.times do
    Book.create!({title: Faker::Lorem.sentence(3,false,3), author: Faker::Name.name, summary: Faker::Lorem.paragraph, page_count: Faker::Number.number(2), isbn: Faker::Number.number(13).to_s, tag_list: 'non-fiction' })
  end

end