class Book < ActiveRecord::Base
  
	has_many :list_books
	has_many :lists, through: :list_books

  acts_as_taggable_on :tag

	validates :title, :author, :summary, presence: true
	validates :isbn, length: { minimum: 10 }

end
