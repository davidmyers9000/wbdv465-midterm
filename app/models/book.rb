class Book < ActiveRecord::Base
  acts_as_taggable_on :tag

	validates :title, :author, :summary, presence: true
	validates :isbn, length: { minimum: 10 }

end
