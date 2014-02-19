class Book < ActiveRecord::Base

  has_many :user_books
  has_many :users, through: :user_books

  validates :title,       presence: true
  validates :author,      presence: true
  validates :summary,     presence: true
  validates :isbn,        presence: true,
                          length: {is: 10}
end
