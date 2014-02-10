class Book < ActiveRecord::Base
	has_many :lists
	has_many :users, through: :lists

  acts_as_taggable_on :tag

	validates :title, :author, :summary, presence: true
	validates :isbn, length: { minimum: 10 }

end
