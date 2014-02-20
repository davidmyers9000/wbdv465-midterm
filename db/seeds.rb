# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "creating admin user.."
User.create!(email: "admin@bookworm.io", password: "password", password_confirmation: "password", role: "admin")

if Rails.env == "development"

  puts "creating member user.."
  User.create!(email: "user@drexel.edu", password: "password", password_confirmation: "password", role: "member")

  puts "creating random users.."
  10.times do
    User.create!(email: Faker::Internet.email(Faker::Name.name), password: "password", password_confirmation: "password", role: "member")
  end

  puts "creating authors"

  6.times do
    Author.create!({name: Faker::Name.name, bio: Faker::Lorem.paragraph})
  end

  puts "creating books with reviews"
  genres = ["Fable", "Fairy tale", "Fantasy", "Fiction", "Folklore", "Historical", "Horror", "Humor", "Legend", "Metafiction", "Mystery", "Mythology", "Poetry", "Sci-Fi", "Short story", "Tall tale" ]

  12.times do
    # generate random genre list
    genre_list = []
    rand(1..3).times do
      genre_list << genres.sample
    end

    # create book
    book = Book.create({title: Faker::Lorem.sentence(3,false,3), author_id: rand(1..6), summary: Faker::Lorem.paragraph, page_count: Faker::Number.number(2), isbn: Faker::Number.number(10), genre_list: genre_list.join(", ")})

    # creating reviews
    rand(0..4).times do
      book.reviews.create({rating: rand(0..5), content: Faker::Lorem.paragraph, created_by_id: rand(2..12)})
    end

    rand(0..10).times do
      book.user_books.create({user_id: rand(2..12), status: UserBook::STATUSES.sample})
    end
  end

end